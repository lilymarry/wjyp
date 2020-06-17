//
//  SgiftVoucher.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "MySgiftVoucher.h"
#import "MySgiftContentCell.h"
#import "MySgiftTop_viewCell.h"
#import "MySgiftVoucherDetail.h"
#import "MyGiftVoucherIndex.h"

#import "SgiftList.h"
@interface MySgiftVoucher ()<UITableViewDataSource,UITableViewDelegate>
@property (assign,nonatomic) NSInteger page;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * giftlist;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (nonatomic, strong) MyGiftVoucherIndex * gift;

@end

@implementation MySgiftVoucher

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.page=1;
 
    [_tabView registerNib:[UINib nibWithNibName:NSStringFromClass([MySgiftContentCell class]) bundle:nil] forCellReuseIdentifier:@"MySgiftContentCell"];
    [_tabView registerNib:[UINib nibWithNibName:NSStringFromClass([MySgiftTop_viewCell class]) bundle:nil] forCellReuseIdentifier:@"MySgiftTop_viewCell"];
    
}

- (void)selectItem:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        
         [self refreshAndLoadMoreMethod];
        
    }else{
        SgiftList * bs = [[SgiftList alloc] init];
      
        [self.navigationController pushViewController:bs animated:YES];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    [self CreatNavBar:@[@"我的赠品券", @"赠品专区"] andIsHaveRightBtn:YES andRightBtnOption:@{@"title":@"完成"} andDefaultHiddenForRightBtn:YES];
    [self refreshAndLoadMoreMethod];
}

- (void)refreshAndLoadMoreMethod{
    _tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    [_tabView.mj_header beginRefreshing];
    
    _tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
    }];
    
}
-(void)getData
{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    MyGiftVoucherIndex *model=[[MyGiftVoucherIndex alloc] init];
    
    model.p=[NSString stringWithFormat:@"%d",(int)self.page];
   
    [model MyGiftVoucherIndexSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MyGiftVoucherIndex * infor = (MyGiftVoucherIndex *)data;
   
        if ([code  intValue]==1) {
            if (_page==1) {
                [self.giftlist removeAllObjects];
                self.giftlist =[NSMutableArray arrayWithArray:infor.data.giftlist];
                self.gift=infor.data.gift;
            }
            else
            {
                if (SWNOTEmptyArr(infor.data.giftlist)) {
                 [self.giftlist addObjectsFromArray:infor.data.giftlist];
                }
                
            }
           
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
  
        [_tabView reloadData];
        [_tabView.mj_footer endRefreshing];
        [_tabView.mj_header endRefreshing];
        
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
        [_tabView.mj_footer endRefreshing];
        [_tabView.mj_header endRefreshing];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"1");
    return 2;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"2");
    if (section==0) {
    
        return 1;
    }
    else
    {
        
    return self.giftlist.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
     NSLog(@"3");
    if (indexPath.section==0) {
        MySgiftTop_viewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MySgiftTop_viewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sumMoneylab.text=_gift.gift_num;
        
        if ([_gift.exchange_money doubleValue]==0&&[_gift.exchange_voucher doubleValue]!=0) {
              cell.tittleLab.text=[NSString stringWithFormat:@"可将%@赠品券换成 %@积分",_gift.sum_money,_gift.exchange_voucher];
        }
        else if ([_gift.exchange_money doubleValue]!=0&&[_gift.exchange_voucher doubleValue]==0) {
            cell.tittleLab.text=[NSString stringWithFormat:@"可将%@赠品券换成 %@余额",_gift.sum_money,_gift.exchange_money];
        }
        else if ([_gift.exchange_money doubleValue]!=0&&[_gift.exchange_voucher doubleValue]!=0) {
           cell.tittleLab.text=[NSString stringWithFormat:@"可将%@赠品券换成 %@余额+ %@积分",_gift.sum_money,_gift.exchange_money,_gift.exchange_voucher];
        }
        else
        {
            cell.tittleLab.text=@"";
            cell.tittleSubLab.hidden=YES;
        }
    
        if ([_gift.exchanged doubleValue]==0&&[_gift.gift_num doubleValue]!=0&&[_gift.sum_money doubleValue]!=0) {
            [cell.exchangeBtn setImage:[UIImage imageNamed:@"提取"] forState:UIControlStateNormal];
            [cell.exchangeLab setTextColor:[UIColor whiteColor]];
            cell.exchangeBtn.enabled=YES;
            cell.tittleSubLab.hidden=NO;
        }
        else
        {
            
            [cell.exchangeBtn setImage:[UIImage imageNamed:@"已提取"] forState:UIControlStateNormal];
            [cell.exchangeLab setTextColor:[UIColor lightTextColor]];
            cell.exchangeBtn.enabled=NO;
            cell.tittleLab.text=@"";
            cell.tittleSubLab.hidden=YES;
        }
        
        __weak typeof(self) WeakSelf = self;
        cell.mySgiftChangeMoneyBtnBlock = ^{
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
            
            [StrongSelf gotoChangMoney];
        };
        return cell;
    }
    else
    {
        MyGiftVoucherIndex *list=       self.giftlist[indexPath.row];
        MySgiftContentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MySgiftContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.create_timeLab.text=[NSString stringWithFormat:@"获取时间:%@",list.create_time];
        cell.moneyLab.text=[NSString stringWithFormat:@"赠品券面值:%@",list.money];
        cell.source_statusLab.text=[NSString stringWithFormat:@"获取途径:%@",list.source_status];

        cell.leve_moneyLab.text=[NSString stringWithFormat:@"¥%.2f", [list.money floatValue]-[list.use_money floatValue]];
        if ([list.type isEqualToString:@"0"]) {
            cell.leveLab.image=[UIImage imageNamed:@"fx_icon_chuji"];
            
        }
       else if ([list.type isEqualToString:@"1"]) {
            cell.leveLab.image=[UIImage imageNamed:@"fx_icon_zhongji"];
            
        }
      else {
            cell.leveLab.image=[UIImage imageNamed:@"fx_icon_gaoji"];
            
        }
        //按钮点击回调
        __weak typeof(self) WeakSelf = self;
        cell.MySgiftContentDetailBtn = ^{
            __strong typeof(WeakSelf) StrongSelf = WeakSelf;
          
          [StrongSelf gotoDetail:list.id];
        };
       
        return cell;
        
    }
   
}
#pragma mark ========== heightForHeaderInSection ==========
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     NSLog(@"4");
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"5");
    if (indexPath.section==0) {
        
        return 129;
    }
  
    else
    {
        return 120;
        
    }
}
-(void)gotoDetail:(NSString *)idStr
{
    MySgiftVoucherDetail *detail=[[MySgiftVoucherDetail alloc]init];
    detail.idstr=idStr;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)changeButtonStatus{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MySgiftTop_viewCell *cell=[_tabView cellForRowAtIndexPath:indexPath];
    cell.exchangeBtn.enabled=YES;

}
-(void)gotoChangMoney
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MySgiftTop_viewCell *cell=[_tabView cellForRowAtIndexPath:indexPath];
    cell.exchangeBtn.enabled=NO;
     [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:1.5f];//防止重复点击
    [MBProgressHUD showMessage:@"兑换中..." toView:self.view];
    MyGiftVoucherIndex *model=[[MyGiftVoucherIndex alloc] init];
    [model MyGiftVoucherChangeIndexSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code isEqualToString:@"200"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               [self refreshAndLoadMoreMethod];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];

    }];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    MySgiftVoucherDetail *detail=[[MySgiftVoucherDetail alloc]init];
//    [self.navigationController pushViewController:detail animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
