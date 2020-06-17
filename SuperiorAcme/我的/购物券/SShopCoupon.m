//
//  SShopCoupon.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCoupon.h"
#import "SShopCouponCell.h"
#import "SShopCouponUseCan.h"
#import "SUserVouchersList.h"
#import "CQPlaceholderView.h"

@interface SShopCoupon () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSArray * arr;//列表normal
    NSArray * brr;//列表out
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SShopCoupon

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SShopCouponCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SShopCouponCell"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    [self showModel];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    [self showModel];
}
- (void)showModel {
    SUserVouchersList * list = [[SUserVouchersList alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sUserVouchersListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SUserVouchersList * list = (SUserVouchersList *)data;
        arr = list.data.normal;
        brr = list.data.out;
        [_mTable reloadData];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"代金券";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"明细" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    SShopCouponUseCan * useCan = [[SShopCouponUseCan alloc] init];
    useCan.type = @"1";
    [self.navigationController pushViewController:useCan animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (arr.count == 0 && brr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    if (section == 0) {
        return arr.count;
    }
    return brr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        
        UIButton * footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2 - 75, 0, 150, 50)];
        [footer addSubview:footerBtn];
        [footerBtn setTitle:@"已过期代金券" forState:UIControlStateNormal];
//        [footerBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        footerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [footerBtn setTitleColor:WordColor forState:UIControlStateNormal];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 25, (ScreenW - 150 - 30)/2, 1)];
        [footer addSubview:line1];
        line1.backgroundColor = MyLine;
        
        UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2 + 50 + 15, 25, (ScreenW - 150 - 30)/2, 1)];
        [footer addSubview:line2];
        line2.backgroundColor = MyLine;
        
        return footer;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SShopCouponCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SShopCouponCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showTimeView.hidden = YES;
    
    if (indexPath.section == 0) {
        cell.rigthImageR.image = [UIImage imageNamed:@"优惠券有效"];
        cell.rightImageR_sub.image = [UIImage imageNamed:@"优惠券有效R"];
        cell.price.textColor = [UIColor redColor];
        
        SUserVouchersList * list = arr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.price.text = [NSString stringWithFormat:@"￥%@",list.now_money];
        cell.vou_id.text = [NSString stringWithFormat:@"代金券编码 %@",list.id];
        cell.all_money.text = [NSString stringWithFormat:@"代金券面值￥%.2f",[list.now_money floatValue] + [list.use_money floatValue]];
        cell.time.text = [NSString stringWithFormat:@"失效日期:%@",list.end_time];
        cell.source_status.text = [NSString stringWithFormat:@"获取途径:%@",list.source_status];
        
    } else {
        cell.rigthImageR.image = [UIImage imageNamed:@"优惠券过期"];
        cell.rightImageR_sub.image = [UIImage imageNamed:@"优惠券失效R"];
        cell.price.textColor = WordColor;
        
        SUserVouchersList * list = brr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.price.text = [NSString stringWithFormat:@"￥%@",list.now_money];
        cell.vou_id.text = [NSString stringWithFormat:@"代金券编码 %@",list.id];
        cell.all_money.text = [NSString stringWithFormat:@"代金券面值￥%.2f",[list.now_money floatValue] + [list.use_money floatValue]];
        cell.time.text = [NSString stringWithFormat:@"失效日期:%@",list.end_time];
        cell.source_status.text = [NSString stringWithFormat:@"获取途径:%@",list.source_status];

    }
    
    
    return cell;
}
@end
