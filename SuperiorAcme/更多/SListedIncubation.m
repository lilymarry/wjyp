//
//  SListedIncubation.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SListedIncubation.h"
#import "SWelfareAgencyCell.h"
#import "SNBannerView.h"
#import "SListedIncubation_infor.h"

#import "SCompanyDevelopCompanyList.h"
#import "CQPlaceholderView.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"

@interface SListedIncubation () <SNBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView * placeholderView;
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SListedIncubation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SWelfareAgencyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWelfareAgencyCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)initRefresh
{
    __block SListedIncubation * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}

#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    SCompanyDevelopCompanyList * list = [[SCompanyDevelopCompanyList alloc] init];
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sCompanyDevelopCompanyListSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SCompanyDevelopCompanyList * list = (SCompanyDevelopCompanyList *)data;
        
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self model:list.data.ads URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        _mTable.tableHeaderView = banner;
        
        SCompanyDevelopCompanyList * list_banner = list.data.ads.firstObject;
        url_merchant_id = list_banner.merchant_id;
        url_goods_id = list_banner.goods_id;
        url_href = list_banner.href;
        
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.mer_list];
            [_mTable.mj_footer resetNoMoreData];
        } else {
            if (list.data.mer_list.count) {
                
                [arr addObjectsFromArray:list.data.mer_list];
                [_mTable.mj_footer endRefreshing];
                
            } else {
                
                [_mTable.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [_mTable.mj_header endRefreshing];
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    if (url_merchant_id != nil && ![url_merchant_id isEqualToString:@""] && ![url_merchant_id  isEqualToString:@"0"]) {
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = url_merchant_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (url_goods_id != nil && ![url_goods_id isEqualToString:@""] && ![url_goods_id isEqualToString:@"0"]) {
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = url_goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (url_href != nil && ![url_href isEqualToString:@""] && ![url_href isEqualToString:@"0"]) {
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = url_href;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"优质商家";
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
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
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
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWelfareAgencyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWelfareAgencyCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SCompanyDevelopCompanyList * list = arr[indexPath.section];
    [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.face_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SCompanyDevelopCompanyList * list = arr[indexPath.section];

    SListedIncubation_infor * infor = [[SListedIncubation_infor alloc] init];
    infor.company_id = list.company_id;
    [self.navigationController pushViewController:infor animated:YES];
}
@end
