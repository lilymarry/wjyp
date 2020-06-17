//
//  SListedIncubation_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SListedIncubation_infor.h"
#import "SGoodsInfor_nav.h"
#import "SListedIncubation_inforCell.h"
#import "SOnlineShopInfor.h"

#import "SCompanyDevelopCompanyInfo.h"

@interface SListedIncubation_infor () <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    SGoodsInfor_nav * nav;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIWebView *mWeb;
@end

@implementation SListedIncubation_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SListedIncubation_inforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SListedIncubation_inforCell"];
    
    //默认隐藏企业店铺
    _mTable.hidden = YES;
    _mWeb.delegate = self;
    
    SCompanyDevelopCompanyInfo * infor = [[SCompanyDevelopCompanyInfo alloc] init];
    infor.company_id = _company_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sCompanyDevelopCompanyInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SCompanyDevelopCompanyInfo * infor = (SCompanyDevelopCompanyInfo *)data;
            
            [_mWeb loadHTMLString:infor.data.content baseURL:nil];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
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
    
    nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
    self.navigationItem.titleView = nav;
    nav.twoBtn_WWW.constant = 70;
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    
    //企业介绍
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.oneBtn setTitle:@"企业介绍" forState:UIControlStateNormal];
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //隐藏
    nav.twoBtn.hidden = YES;
    //企业店铺
    [nav.threeBtn setTitle:@"企业店铺" forState:UIControlStateNormal];
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 企业介绍
- (void)oneBtnClick {
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    _mTable.hidden = YES;
}
#pragma mark - 企业店铺
- (void)threeBtnClick {
//    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
//    [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    line.frame = CGRectMake(nav.threeBtn.frame.origin.x, 28, 75, 2);
//    _mTable.hidden = NO;
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    infor.merchant_id = _company_id;
    [self.navigationController pushViewController:infor animated:YES];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SListedIncubation_inforCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SListedIncubation_inforCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    [self.navigationController pushViewController:infor animated:YES];
}
@end
