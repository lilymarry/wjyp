//
//  WACatchList.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WACatchList.h"
#import "WACatchListCell.h"
#import "WAVideoPlay.h"
#import "WAInRoom.h"
#import "UserCatchHistoryModel.h"
#import "CommonHelp.h"
#import "GCDSocketManager.h"
#import "WAInRoom.h"
#import "EnterRoomModel.h"
@interface WACatchList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (assign,nonatomic) NSInteger page;
@property (strong, nonatomic) IBOutlet UIView *noDataView;

@end

@implementation WACatchList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"抓中记录";
   _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
   [_mTable registerNib:[UINib nibWithNibName:@"WACatchListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WACatchListCell"];
    
    [self getData];
}

-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    UserCatchHistoryModel *model=[[UserCatchHistoryModel alloc] init];
    [model UserCatchHistoryModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            UserCatchHistoryModel *model=(UserCatchHistoryModel *)data;
        
            
                self->dataArr =[NSMutableArray arrayWithArray:model.data];
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }

        if (self->dataArr .count==0) {
            _noDataView.hidden=NO;
            _mTable.hidden=YES;
        }
        else
        {
            _noDataView.hidden=YES;
            _mTable.hidden=NO;
        }
 

        [self->_mTable reloadData];

    } andFailure:^(NSError * _Nonnull error) {
       
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WACatchListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WACatchListCell" forIndexPath:indexPath];
    
      UserCatchHistoryModel *model=dataArr[indexPath.row];

    [ cell.headImaview sd_setImageWithURL:[NSURL URLWithString:model.head_pic]
                          placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    cell.nameLab.text=[NSString stringWithFormat:@"%@ %@",model.nickname,[CommonHelp timeWithTimeIntervalString:model.create_time andFormatter:@"YYYY-MM-dd"]];
   
    cell.contentLab.text=[NSString stringWithFormat:@"成功抓到了%@",model.goods_name];
   
    [cell.oneBtn addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    [cell.twoBtn addTarget:self action:@selector(enterRomm:) forControlEvents:UIControlEventTouchUpInside];
    cell.oneBtn .tag=indexPath.row;
    cell.twoBtn .tag=indexPath.row;

    return cell;
    
}
-(void)playVideo:(id)sender
{
    UIButton *but=(UIButton *)sender;
   UserCatchHistoryModel *model=dataArr[but.tag];
    if (model.url.length>0) {
        WAVideoPlay *play=[[WAVideoPlay alloc]init];
        play.playUrl=model.url;
        [self.navigationController pushViewController:play animated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"视频无效，请稍后" toView:self.view];
        
    }
}
-(void)enterRomm:(id)sender
{
    UIButton *but=(UIButton *)sender;
    UserCatchHistoryModel *model=dataArr[but.tag];
    if ( model.roomBean.mac.length!=0) {
        [MBProgressHUD showMessage:nil toView:self.view];
        EnterRoomModel *room=   [[EnterRoomModel  alloc]init];
        room.id=model.roomBean.id;
        [room EnterRoomModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
            
            if ([code intValue]==200) {
                [[GCDSocketManager sharedSocketManager]connectToServer:@"192.168.0.4" port:@"7771" complete:^(NSString * _Nonnull result) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([result isEqualToString:@"1"]) {
                        WAInRoom *inroom=[[WAInRoom alloc]init];
                        inroom.hidesBottomBarWhenPushed=YES;
                        inroom.id=model.roomBean.id;
                        inroom.mac=model.roomBean.mac;
                        
                        [self.navigationController pushViewController:inroom animated:YES];
                    }
                    else{
                        [MBProgressHUD showError:@"房间连接失败，请稍后再试" toView:self.view];
                    }
                    
                }];
            }
            else
            {
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showError:message toView:self.view];
            }
            
            
        } andFailure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            
        }];
        
        
    }
    else{
        [MBProgressHUD showError:@"房间编号为空" toView:self.view];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}


@end
