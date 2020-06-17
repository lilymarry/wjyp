//
//  MAMineMyWaListDetail.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineMyWaListDetail.h"
#import "WAMineMyWaListDetailTopCell.h"
#import "WAMineMyWaListDetailContentCell.h"
#import "WAMineMyChangMoneyView.h"
#import "CommonHelp.h"
#import "ExchangeCoinModel.h"
#import "ExchangeGoodsModel.h"
@interface WAMineMyWaListDetail ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation WAMineMyWaListDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"商品详情";
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineMyWaListDetailTopCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineMyWaListDetailTopCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineMyWaListDetailContentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineMyWaListDetailContentCell"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        WAMineMyWaListDetailTopCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineMyWaListDetailTopCell" forIndexPath:indexPath];
        [cell.good_ima sd_setImageWithURL:[NSURL URLWithString:_listModel.catGoodsImg]
                              placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
      
   //     if ([_listModel.goodsStatus  intValue]==1) {
          cell.goodNameLab.text=_listModel.goods_name;
//        }
//        else
//        {
//         cell.goodNameLab.text=_listModel.goodsName;
//        }
      
        cell.timeLab.text=[CommonHelp timeWithTimeIntervalString:_listModel.create_time andFormatter:@"YYYY.MM.dd HH:mm:ss"] ;
        return cell;
    }
    else
    {
        WAMineMyWaListDetailContentCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineMyWaListDetailContentCell" forIndexPath:indexPath];
        [cell.headImaView sd_setImageWithURL:[NSURL URLWithString:_listModel.userHeader]
                         placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        cell.nickNameLab.text=_listModel.userNickName;
        cell.RoomStateLab.text=_listModel.depositStatus;
        cell.roomName.text=_listModel.roomName;
        cell.roomNum.text=_listModel.roomId;
        if ([_listModel.coinStatus intValue]==1) {
            cell.moneyChangBtn.hidden=NO;
           
        }
        else
        {
            cell.moneyChangBtn.hidden=YES;
         
        }
        if ([_listModel.goodsStatus intValue]==1) {
            cell.goodChangBtn.hidden=NO;
    
        }
        else
        {
            cell.goodChangBtn.hidden=YES;
          
        }
        if ( cell.moneyChangBtn.hidden==YES&& cell.goodChangBtn.hidden==NO) {
             cell.moneyChangBtnWW.constant=0;
             cell.goodChangBtnWW.constant=ScreenW-54;
        }
        if ( cell.moneyChangBtn.hidden==NO&& cell.goodChangBtn.hidden==YES) {
            cell.moneyChangBtnWW.constant=ScreenW-54;
            cell.goodChangBtnWW.constant=0;
            
            
        }
        if ( cell.moneyChangBtn.hidden==NO&& cell.goodChangBtn.hidden==NO) {
            cell.moneyChangBtnWW.constant=ScreenW/2-47;
            cell.goodChangBtnWW.constant=ScreenW/2-47;
       
            
        }
        __weak typeof(self) weakSelf = self;
        cell.topBtnBlock = ^(NSInteger type) {
            [weakSelf topBtnEvent:type];
        };
        return cell;
    }
    
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 239;
    }
    else
    {
        return 314;
    }
}
- (void)topBtnEvent:(NSInteger)num {
    
    NSString *msgString=nil;
    if (num==1) {
        msgString=@"确定要兑换此商品吗";
    }
    else
    {
        msgString=@"确定要把此商品兑换成银两吗?";
    }
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msgString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showMessage:nil toView:self.view];

        if (num !=1) {
            ExchangeCoinModel *model=[[ExchangeCoinModel alloc]init];
            model.cid=_listModel.roomId;
            model.times=@"1";
            [model ExchangeCoinModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,NSDictionary *coinDic) {
                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if ([code intValue]==200) {
                    WAMineMyChangMoneyView * header = [[WAMineMyChangMoneyView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                    header.moneyLab.text=[NSString stringWithFormat:@"%d",[coinDic[@"coin"] intValue ]];
                    [self.view.window addSubview:header];
                }
                else
                {
                    [MBProgressHUD showSuccess:message toView:self.view];
                }
            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
        else
        {
          
            ExchangeGoodsModel *model=[[ExchangeGoodsModel alloc]init];
            model.cid=_listModel.roomId;
            model.goods_id=_listModel.goods_id;
            [model ExchangeGoodsModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message,id data) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if ([code intValue]==200) {
                 
                }
                else
                {
                    [MBProgressHUD showSuccess:message toView:self.view];
                }
            } andFailure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
            
        }
    
 
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end
