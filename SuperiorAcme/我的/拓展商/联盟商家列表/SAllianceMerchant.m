//
//  SAllianceMerchant.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAllianceMerchant.h"
#import "SAllianceMerchantCell.h"
#import "CQPlaceholderView.h"
#import "SAM_Recommend.h"
#import "SRecommendingBusinessList.h"

@interface SAllianceMerchant ()  <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    CQPlaceholderView *placeholderView;
    NSArray * arr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SAllianceMerchant

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SAllianceMerchantCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SAllianceMerchantCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 5;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"线下店铺商家推荐";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidAppear:(BOOL)animated {
    SRecommendingBusinessList * list = [[SRecommendingBusinessList alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sRecommendingBusinessListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SRecommendingBusinessList * list = (SRecommendingBusinessList *)data;
        arr = list.data;
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAllianceMerchantCell * Cell = [_mTable dequeueReusableCellWithIdentifier:@"SAllianceMerchantCell" forIndexPath:indexPath];
    Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SRecommendingBusinessList * list = arr[indexPath.row];
    [Cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    Cell.merchant_name.text = list.merchant_name;
    if ([list.type isEqualToString:@"1"]) {
        [Cell.thisRBtn setTitle:@" 联盟商家" forState:UIControlStateNormal];
    } else {
        [Cell.thisRBtn setTitle:@" 无界驿店" forState:UIControlStateNormal];
    }
    if ([list.status isEqualToString:@"1"] || [list.status isEqualToString:@"0"]) {
        Cell.status.text = @"审核中";
    } else if ([list.status isEqualToString:@"4"]) {
        Cell.status.text = @"待入驻";
    }else if ([list.status isEqualToString:@"5"]) {
        Cell.status.text = @"入驻失败";
    }else if ([list.status isEqualToString:@"6"]) {
        Cell.status.text = @"入驻成功";
    }else if ([list.status isEqualToString:@"7"]) {
        Cell.status.text = @"入驻中";
    }else if ([list.status isEqualToString:@"3"] || [list.status isEqualToString:@"2"]) {
        Cell.status.text = @"审核拒绝";
    }
    Cell.create_time.text = list.create_time;
    Cell.user_name.text = list.user_name;
    Cell.user_phone.text = list.user_phone;
    Cell.city_street.text = [NSString stringWithFormat:@"%@%@",list.city,list.street];
    
    return Cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SRecommendingBusinessList * list = arr[indexPath.row];
    SAM_Recommend * am_re = [[SAM_Recommend alloc] init];
    am_re.recommending_id = list.recommending_id;
    am_re.showModel_isno = YES;
    am_re.status = list.status;
    if ([list.type isEqualToString:@"1"]) {
        am_re.left_right = NO;
    } else {
        am_re.left_right = YES;
    }
    [self.navigationController pushViewController:am_re animated:YES];
}
- (IBAction)submitBtn:(UIButton *)sender {
    SAM_Recommend * am_re = [[SAM_Recommend alloc] init];
    [self.navigationController pushViewController:am_re animated:YES];
}
@end
