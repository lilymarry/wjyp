//
//  SWelfareAgency.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareAgency.h"
#import "SGoodsInfor_nav.h"
#import "CBAutoScrollLabel.h"
#import "SWelfareAgencyCell.h"
#import "SWelfareAgency_play.h"
#import "SOnlineShop_ClassView.h"
#import "SCodePackage_twoCell.h"
#import "SNPageView.h"
#import "SWelfareAgencyCoupon.h"
#import "CQPlaceholderView.h"
#import "SWelfareFaceList.h"
#import "GYChangeTextView.h"
#import "SWelfareTicketList.h"
#import "SWelfareGetTicket.h"//领券
#import "SWelfareBonusList.h"
#import "SWelfareShareContent.h"
#import "AShare.h"

@interface SWelfareAgency () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate,GYChangeTextViewDelegate>
{
    SGoodsInfor_nav * nav;
    UIButton * rigthBtn;
    SWelfareAgencyCoupon * content;
    SNPageView * pageView;
    BOOL pageView_is;//如果是NO第一次进界面并且第一次点击领券，那么创建 YES：不进行NO的操作
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView * placeholderView;
    GYChangeTextView * tView;
    
    BOOL is_no;//默认NO领红包 YES领券
    NSString * cate_id;//分类id（可选）
    NSMutableArray * brr;
}
@property (strong, nonatomic) IBOutlet UIView *autoLabel;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SWelfareAgency

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SWelfareAgencyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWelfareAgencyCell"];
    
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)initRefresh
{
    __block SWelfareAgency * blockSelf = self;
    if (is_no == NO) {
        _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    } else {
        content.mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        content.mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    }
}

#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}
- (void)showModel {
    if (is_no == NO) {
        SWelfareFaceList * list = [[SWelfareFaceList alloc] init];
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sWelfareFaceListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SWelfareFaceList * list = (SWelfareFaceList *)data;
            
            [tView removeFromSuperview];
            tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 40, 40)];
            tView.delegate = self;
            [_autoLabel addSubview:tView];
            NSMutableArray * arr_title = [[NSMutableArray alloc] init];
            for (SWelfareFaceList * listTitle in list.data.announce) {
                [arr_title addObject:listTitle.title];
            }
            if (arr_title.count != 0) {
                [tView animationWithTexts:arr_title];
            }
            
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.list.count) {
                    
                    [arr addObjectsFromArray:list.data.list];
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
    } else {
        pageView_is = YES;//pageView已经创建了，不需要再次创建了
        SWelfareTicketList * list = [[SWelfareTicketList alloc] init];
        list.cate_id = cate_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sWelfareTicketListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SWelfareTicketList * list = (SWelfareTicketList *)data;
            
            if (page == 1) {
                brr = [NSMutableArray arrayWithArray:list.data.ticket_list];
                [content.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.ticket_list.count) {
                    
                    [brr addObjectsFromArray:list.data.ticket_list];
                    [content.mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [content.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [content.mTable.mj_header endRefreshing];
            [content.mTable reloadData];
            [content showModel:brr];
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
    self.navigationItem.titleView = nav;
    nav.twoBtn_WWW.constant = 70;
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    
    //领红包
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.oneBtn setTitle:@"领红包" forState:UIControlStateNormal];
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //隐藏
    nav.twoBtn.hidden = YES;
    //领券
    [nav.threeBtn setTitle:@"领券" forState:UIControlStateNormal];
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 领红包
- (void)oneBtnClick {
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    pageView.hidden = YES;
    is_no = NO;
}
#pragma mark - 领券
- (void)threeBtnClick {
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = NO;
    pageView.hidden = NO;
    is_no = YES;
    
    if (pageView_is == NO) {
        SWelfareTicketList * list = [[SWelfareTicketList alloc] init];
        list.cate_id = @"";
        list.p = @"1";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sWelfareTicketListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SWelfareTicketList * list = (SWelfareTicketList *)data;
            
            //类型name
            NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
            NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
            for (SWelfareTicketList * list_type  in list.data.top_nav) {
                [typeArr_name addObject:list_type.short_name];
                [typeArr_id addObject:list_type.cate_id];
            }
            //类型class
            NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
            for (int i = 0; i < typeArr_name.count; i++) {
                [typeArr_class addObject:[SWelfareAgencyCoupon class]];
            }
            
            pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
            pageView.subViews = typeArr_class;
            pageView.titles = typeArr_name;
            pageView.titleWidth = 100;
            pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
            pageView.sliderColor = WordColor;
            pageView.defaultSelectedIndex = 0;
            pageView.topTitleViewColor = [UIColor whiteColor];
            pageView.goundNormalColor = [UIColor whiteColor];
            __block SWelfareAgency * gSelf = self;
            [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
                if (index > 1) {
                    [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
                }
                content = subView;
                page = 1;
                cate_id = typeArr_id[index];
                [gSelf initRefresh];
                [gSelf showModel];
                content.SWelfareAgencyCoupon_ShowModelAgain = ^{
                    page = 1;
                    [gSelf showModel];
                };
                content.SWelfareAgencyCoupon_get = ^(NSString *ticket_id) {
                    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                        SLand * land = [[SLand alloc] init];
                        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                        land.modalPresent = YES;
                        [gSelf presentViewController:landNav animated:YES completion:nil];
                        land.SLand_showModel = ^{
                            [gSelf showModel];
                        };
                        return;
                    }
                    SWelfareGetTicket * get = [[SWelfareGetTicket alloc] init];
                    get.ticket_id = ticket_id;
                    [MBProgressHUD showMessage:nil toView:gSelf.view];
                    [get sWelfareGetTicketSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:gSelf.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                page = 1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:gSelf.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                    }];
                };
                
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
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
    
    SWelfareFaceList * list = arr[indexPath.section];
    [cell.thisImage sd_setImageWithURL:[NSURL URLWithString:list.bonus_face] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWelfareFaceList * list = arr[indexPath.section];
    
    __block SWelfareAgency * gSelf = self;
    SWelfareBonusList * bonus = [[SWelfareBonusList alloc] init];
    bonus.bonus_id = list.bonus_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [bonus sWelfareBonusListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SWelfareBonusList * bonus = (SWelfareBonusList *)data;
            //初始化
            SWelfareAgency_play * play = [[SWelfareAgency_play alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [[[UIApplication sharedApplication] keyWindow] addSubview:play];
            //展示数据
            [play showModel:bonus.data.ads_list andLogo:bonus.data.logo andName:bonus.data.merchant_name];
            //销毁
            play.SWelfareAgency_play_back = ^{
                [play removeFromSuperview];
            };
            //分享
            play.SWelfareAgency_play_share = ^{
                [play removeFromSuperview];
                [gSelf shareNow:list.bonus_id];
            };
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
#pragma mark - 领红包分享内容
- (void)shareNow:(NSString *)bonus_id {
    SWelfareShareContent * shareCon = [[SWelfareShareContent alloc] init];
    shareCon.bonus_id = bonus_id;
    [shareCon sWelfareShareContentSuccess:^(NSString *code, NSString *message, id data) {
        if ([code isEqualToString:@"1"]) {
            SWelfareShareContent * shareCon = (SWelfareShareContent *)data;
            
//            UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//            backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//            [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
//            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//            view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//            [self.view addSubview:view];
            
            AShare * shareVC = [[AShare alloc] init];
            shareVC.thisUrl = shareCon.data.url;
            shareVC.thisImage = shareCon.data.pic;
            shareVC.thisTitle = shareCon.data.title;
            shareVC.thisContent = shareCon.data.content;
            shareVC.thisType = @"4";
            shareVC.id_val = bonus_id;
            shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:shareVC animated:YES completion:nil];
            shareVC.AShare_back = ^{
//                [backGroundView removeFromSuperview];
//                [view removeFromSuperview];
            };
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
