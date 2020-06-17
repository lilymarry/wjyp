//
//  WAMine.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMine.h"
#import "WAMine_top.h"
#import "WAMineListCell1.h"
#import "WAMoney.h"
#import "WAMineMyWaList.h"
#import "WAMineGameList.h"

#import "WAMineFriend.h"
#import "WAUserCenterModel.h"
#import "SAddress.h"
#import "WAFirstFocus.h"
#import "SShopCouponUseCan.h"
#import "WAMoneyPayList.h"
#define NAVBAR_CHANGE_POINT 50
@interface WAMine ()<UITableViewDelegate,UITableViewDataSource>
{
    WAMine_top *top;
  
}
//@property (strong, nonatomic) IBOutlet UITableView *mTable;

@property (strong, nonatomic)  UITableView *mTable;
@end

@implementation WAMine

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
 
  
    _mTable.delegate = self;
    _mTable.dataSource = self;
   
    [self.view addSubview:_mTable];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"WAMineListCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WAMineListCell1"];
    
    [self createSMineTopView];
}
-(void)getWaWaData
{
     [MBProgressHUD showMessage:nil toView:self.view];
    WAUserCenterModel *mode=[[WAUserCenterModel alloc]init];
    [mode WAUserCenterModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==200) {
            WAUserCenterModel *mode=(WAUserCenterModel *)data;
    
         [top.headImaView sd_setImageWithURL:[NSURL URLWithString:mode.data.head_pic]
        placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        top.nameLab.text=mode.data.nickname;
            
            NSString *str2 =@"我的银两";
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",mode.data.chance_num,str2]];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:252/255.0 green:73/255.0 blue:155/255.0 alpha:1] range:NSMakeRange(0 , mode.data.chance_num.length)];
            [top.oneBtn setAttributedTitle:AttributedStr forState:UIControlStateNormal];
            
            NSString *str4 =@"我的娃娃";
            NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",mode.data.my_catcher_num,str4]];
            [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:252/255.0 green:73/255.0 blue:155/255.0 alpha:1] range:NSMakeRange(0 ,mode.data.my_catcher_num.length)];
            [top.twoBtn setAttributedTitle:AttributedStr1 forState:UIControlStateNormal];
            
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
-(void)viewWillAppear:(BOOL)animated
{
    adjustsScrollViewInsets_NO(_mTable, self);
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //透明
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:_mTable];
  
    // [self.navigationController.navigationBar lt_setBackgroundColor:navigationColor];
        [self getWaWaData];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar lt_reset];
   
}
- (void)createSMineTopView {
    top = [[WAMine_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 266)];
    __weak typeof(self) weakSelf = self;
    top.topBtnBlock = ^(NSInteger type) {
        [weakSelf topBtnEvent:type];
    };
    _mTable.tableHeaderView = top;
   
}
- (void)topBtnEvent:(NSInteger)num {
    
    if (num==1) {
        WAMoney *money=[[WAMoney alloc]init];
         money.hidesBottomBarWhenPushed=YES;
         money.presentingView=NO;
        [self.navigationController pushViewController:money animated:YES];
    }
    else
    {
        WAMineMyWaList *money=[[WAMineMyWaList alloc]init];
          money.hidesBottomBarWhenPushed=YES;
        money.isUser=NO;
        [self.navigationController pushViewController:money animated:YES];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 3;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   // if (section == 2) {
        return 10;
   // }
   // return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    WAMineListCell1 * cell = [_mTable dequeueReusableCellWithIdentifier:@"WAMineListCell1" forIndexPath:indexPath];
    cell.nameLab.text = @[@[@"我的收藏",@"收货地址"],@[@"游戏记录" ,@"兑换记录",@"好友助力"],@[@"背景音乐",@"操作音效"]][indexPath.section][indexPath.row];
    
    if (indexPath.section<2) {
        cell.switchBtn.hidden=YES;
        cell.imaView.hidden=NO;
    }
    else
    {
        cell.switchBtn.hidden=NO;
        cell.imaView.hidden=YES;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
         if (indexPath.row==0) {
        WAFirstFocus *focus=[[WAFirstFocus alloc]init];
        focus.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:focus animated:YES];
         }
        else {
            SAddress * address = [[SAddress alloc] init];
            address.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:address animated:YES];
        }
       
    }
   else if (indexPath.section==1) {
        //游戏记录
        if (indexPath.row==0) {
            WAMineGameList  *list=[[WAMineGameList alloc]init];
            list.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:list animated:YES];
        }
        //兑换记录
        if (indexPath.row==1) {
            WAMoneyPayList *list=[WAMoneyPayList alloc];
            list.flag=@"2";
            list.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:list animated:YES];
            
//            SShopCouponUseCan *useCan=[[SShopCouponUseCan alloc]init];
//            useCan.type = @"10";
//            useCan.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:useCan animated:YES];
            
//            WAExchangList  *list=[[WAExchangList alloc]init];
//            list.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:list animated:YES];
        }
        if (indexPath.row==2) {
            WAMineFriend *list=[[WAMineFriend alloc]init];
            list.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:list animated:YES];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor * color = navigationColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
       
        
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        
       
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
      _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        _mTable.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}


@end
