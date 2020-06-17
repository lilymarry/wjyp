//
//  WAMineGameList.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineGameList.h"
#import "WAMineGameListCell.h"
#import "WAMineGameDetail.h"
#import "MyCatchHistoryModel.h"
#import "CommonHelp.h"
@interface WAMineGameList ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (assign,nonatomic) NSInteger page;
@end

@implementation WAMineGameList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"游戏记录";
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineGameListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineGameListCell"];
    [self refreshAndLoadMoreMethod];
}
- (void)refreshAndLoadMoreMethod{
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_mTable.mj_header beginRefreshing];
    
    _mTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MyCatchHistoryModel *model=[[MyCatchHistoryModel alloc] init];
    
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
    
    
    [model MyCatchHistoryModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            MyCatchHistoryModel *model=(MyCatchHistoryModel *)data;
            if (self->_page==1) {
                self->dataArr =[NSMutableArray arrayWithArray:model.data];
            }
            else
            {
                [self->dataArr addObjectsFromArray:model.data];
            }
            
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
        [self->_mTable.mj_footer endRefreshing];
        [self->_mTable.mj_header endRefreshing];
        
        [self->_mTable reloadData];
        
    } andFailure:^(NSError * _Nonnull error) {
        [self->_mTable.mj_footer endRefreshing];
        [self->_mTable.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WAMineGameListCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineGameListCell" forIndexPath:indexPath];
   
    MyCatchHistoryModel *model=dataArr[indexPath.row];
    
   [ cell.headImaView sd_setImageWithURL:[NSURL URLWithString:model.room_pic]
                         placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    cell.nameLab.text=[NSString stringWithFormat:@"%@",model.name];
    if ([model.mode intValue]==0) {
        cell.resultLab.text=[NSString stringWithFormat:@"抓取失败"];
           [cell.resultLab setTextColor:[UIColor
                                         colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    }
    else{
        cell.resultLab.text=[NSString stringWithFormat:@"抓取成功"];
        [cell.resultLab setTextColor:navigationColor];
    }
    cell.timeLab.text=[CommonHelp timeWithTimeIntervalString:model.update_time  andFormatter:@"YYYY.MM.dd HH:mm:ss"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WAMineGameDetail *detail=[[WAMineGameDetail alloc]init];
    detail.model=dataArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}

@end
