//
//  SOnlineShopInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 170 - 64

#import "SOnlineShopInfor.h"
#import "AShare.h"
#import "SOnlineShopInforCell.h"
#import "SOnlineShopInfor_Top.h"
#import "SLineShop_inforSub.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell.h"
#import "SOnlineShopInfor_ClassView.h"
#import "SGoodsInfor.h"
#import "SLineShop_infor_CouponView.h"
#import "SLineShop_infor_Left_subCon_R.h"

#import "SMerchantMerIndex.h"//店铺首页
#import "CQPlaceholderView.h"
#import "SMerchantGoodsList.h"//全部商品、热销商品、最新上架
#import "SOnlineShopCell_2.h"
#import "SMerchantLimitList.h"//限量购
#import "SMerchantGroupList.h"//拼团购
#import "SMerchantPreList.h"//无界预购
#import "SMerchantAuctionList.h"//竞拍汇
#import "SMerchantOneBuyList.h"//积分抽奖
#import "SLotInfor.h"//竞拍汇详情
#import "SIndianaInfor.h"//积分抽奖详情
#import "SUserCollectAddCollect.h"
#import "SUserCollectDelOneCollect.h"
#import "SWelfareGetTicket.h"
#import "SMessageInfor.h"
#import "WAInRoom.h"
@interface SOnlineShopInfor () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate,UIScrollViewDelegate,CQPlaceholderViewDelegate>
{
    UIButton * rightBtn_sub;
    BOOL collect_isno;//NO未收藏 YES已收藏
    SOnlineShopInfor_Top * top;
    SOnlineShopInfor_ClassView * classView;
    CGFloat class_HHH;
    SLineShop_infor_Left_subCon_R * rrr;
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView * placeholderView;
    
    NSString * merchant_name;//"店铺名称",
    NSString * logo;
    NSString * merchant_slogan;//"店铺口号",//用于显示
    NSString * announce;//'店铺公告',
    NSString * ticket_num;//"2",//优惠券数量
    NSArray * ticket_list;//优惠券列表
    SLineShop_infor_CouponView * coup;
    
    NSString * nowType;//店铺首页 全部商品 热销商品 最新上架 活动商品
    
    XRWaterfallLayout * waterfall;
    
    NSString * share_url;//分享链接
    NSString * share_img;//"分享图片",
    NSString * share_content;//"分享内容"
    
    NSString * thisSearchGoods;//搜索的内容
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SOnlineShopInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SOnlineShopInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOnlineShopInforCell"];
    
//    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
//    [_mTable addSubview:placeholderView];
//    placeholderView.hidden = YES;

    thisSearchGoods = @"";//默认没有搜索内容
    
    waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
    waterfall.delegate = self;
    _mCollect.collectionViewLayout = waterfall;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell_2" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell_2"];
    
    top = [[SOnlineShopInfor_Top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 170 + 100 + 70)];
    _mTable.tableHeaderView = top;
    top.searchTF.text = thisSearchGoods;
    [top.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rrr = [[SLineShop_infor_Left_subCon_R alloc] initWithFrame:CGRectMake(0, 170 + 100, ScreenW, 70)];
    [top addSubview:rrr];
    [top.noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    __block SOnlineShopInfor * gSelf = self;
    rrr.SLineShop_infor_Left_subCon_R_show = ^{
        coup = [[SLineShop_infor_CouponView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        [[[UIApplication sharedApplication] keyWindow] addSubview:coup];
        [coup showModel:ticket_list];
        coup.SLineShop_infor_CouponView_Back = ^{
            [coup removeFromSuperview];
        };
        coup.SLineShop_infor_CouponView_get = ^(NSString *ticket_id) {
            if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                [coup removeFromSuperview];
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
                [coup removeFromSuperview];
                if ([code isEqualToString:@"1"]) {
                    [coup removeFromSuperview];
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
    };
    //默认店铺首页
    [top type:@"1"];
    //默认隐藏mCollect
    _mCollect.hidden = YES;
    //店铺信息
    [top.topShopBtn addTarget:self action:@selector(topShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [top.oneBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.twoBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.threeBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.fourBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.fiveBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [top.oneBtn setTag:1];
    [top.twoBtn setTag:2];
    [top.threeBtn setTag:3];
    [top.fourBtn setTag:4];
    [top.fiveBtn setTag:5];
    
    nowType = @"店铺首页";
    page = 1;
    [self initRefresh];
    [self showModel];
    
#pragma mark - 活动商品初始化
    classView = [[SOnlineShopInfor_ClassView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:classView];
    classView.hidden = YES;
    classView.SOnlineShopInfor_ClassView_Back = ^{
        classView.hidden = YES;
    };
    classView.SOnlineShopInfor_ClassView_Choice = ^(NSString *typeName, NSInteger index) {
        classView.hidden = YES;
        [top.fiveBtn setTitle:typeName forState:UIControlStateNormal];
        if (index == 0) {
            nowType = @"限量购";
        }
        if (index == 1) {
            nowType = @"拼团购";
        }
        if (index == 2) {
            nowType = @"无界预购";
        }
        if (index == 3) {
            nowType = @"竞拍汇";
        }
        if (index == 4) {
            nowType = @"积分夺宝";
        }
        page = 1;
        [self initRefresh];
        [self showModel];
    };
}

- (void)initRefresh
{
    __block SOnlineShopInfor * blockSelf = self;
    if ([nowType isEqualToString:@"店铺首页"]) {
        _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    } else {
        _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
- (void)searchBtnClick {
    thisSearchGoods = top.searchTF.text;
    UIButton * btn = [[UIButton alloc] init];
    [btn setTag:2];
    [self choiceClick:btn];
}
- (void)showModel {
    if ([nowType isEqualToString:@"店铺首页"]) {
        SMerchantMerIndex * list = [[SMerchantMerIndex alloc] init];
        list.merchant_id = _merchant_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantMerIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SMerchantMerIndex * list = (SMerchantMerIndex *)data;
                if ([list.data.is_collect integerValue] == 0) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                merchant_name = list.data.merchant_name;
                logo = list.data.logo;
                merchant_slogan = list.data.merchant_slogan;
                announce = list.data.announce;
                ticket_num = list.data.ticket_num;
                ticket_list = list.data.ticket_list;
                
                share_url = list.data.share_url;
                share_img = list.data.share_img;
                share_content = list.data.share_content;
                
                
                top.merchant_name.text = merchant_name;
                [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                top.topContent.text = merchant_slogan;
                top.noticeTitle.text = announce;
                rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
                if ([ticket_num integerValue] == 0) {
                    rrr.hidden = YES;
                    [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                    top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);
                } else {
                    rrr.hidden = NO;
                    [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                    top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
                }
                
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data.ads_list];
                    [_mTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.ads_list.count) {
                        
                        [arr addObjectsFromArray:list.data.ads_list];
                        [_mTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_mTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                
                [_mTable.mj_header endRefreshing];
                [_mTable reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
                [self performSelector:@selector(goBack) withObject:nil afterDelay:1.0];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            
        }];
    } else if ([nowType isEqualToString:@"全部商品"] || [nowType isEqualToString:@"热销商品"] || [nowType isEqualToString:@"最新上架"]) {
        waterfall.columnCount = 2;
        
        SMerchantGoodsList * list = [[SMerchantGoodsList alloc] init];
        list.merchant_id = _merchant_id;
        if ([nowType isEqualToString:@"全部商品"]) {
            list.is_hot = @"";
            list.thisNew_buy = @"";
            list.search_goods = thisSearchGoods;
        } else if ([nowType isEqualToString:@"热销商品"]) {
            list.is_hot = @"1";
            list.thisNew_buy = @"";
        } else if ([nowType isEqualToString:@"最新上架"]) {
            list.is_hot = @"";
            list.thisNew_buy = @"1";
        }
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantGoodsListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SMerchantGoodsList * list = (SMerchantGoodsList *)data;
            if ([list.data.is_collect integerValue] == 0) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            }
            
            merchant_name = list.data.merchant_name;
            logo = list.data.logo;
            merchant_slogan = list.data.merchant_slogan;
            announce = list.data.announce;
            ticket_num = list.data.ticket_num;
            ticket_list = list.data.ticket_list;
            
            
            top.merchant_name.text = merchant_name;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.topContent.text = merchant_slogan;
            top.noticeTitle.text = announce;
            rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
            if ([ticket_num integerValue] == 0) {
                rrr.hidden = YES;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);

            } else {
                rrr.hidden = NO;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
            }
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.goods_list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.goods_list.count) {
                    
                    [arr addObjectsFromArray:list.data.goods_list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([nowType isEqualToString:@"限量购"] ) {
        waterfall.columnCount = 2;
        
        SMerchantLimitList * list = [[SMerchantLimitList alloc] init];
        list.merchant_id = _merchant_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantLimitListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([list.data.is_collect integerValue] == 0) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            }
            
            SMerchantLimitList * list = (SMerchantLimitList *)data;
            
            merchant_name = list.data.merchant_name;
            logo = list.data.logo;
            merchant_slogan = list.data.merchant_slogan;
            announce = list.data.announce;
            ticket_num = list.data.ticket_num;
            ticket_list = list.data.ticket_list;
            
            
            top.merchant_name.text = merchant_name;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.topContent.text = merchant_slogan;
            top.noticeTitle.text = announce;
            rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
            if ([ticket_num integerValue] == 0) {
                rrr.hidden = YES;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);
            } else {
                rrr.hidden = NO;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
            }
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.goods_list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.goods_list.count) {
                    
                    [arr addObjectsFromArray:list.data.goods_list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([nowType isEqualToString:@"拼团购"] ) {
        waterfall.columnCount = 2;

        SMerchantGroupList * list = [[SMerchantGroupList alloc] init];
        list.merchant_id = _merchant_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantGroupListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SMerchantGroupList * list = (SMerchantGroupList *)data;
            if ([list.data.is_collect integerValue] == 0) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            }
            
            merchant_name = list.data.merchant_name;
            logo = list.data.logo;
            merchant_slogan = list.data.merchant_slogan;
            announce = list.data.announce;
            ticket_num = list.data.ticket_num;
            ticket_list = list.data.ticket_list;
            
            
            top.merchant_name.text = merchant_name;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.topContent.text = merchant_slogan;
            top.noticeTitle.text = announce;
            rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
            if ([ticket_num integerValue] == 0) {
                rrr.hidden = YES;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);
            } else {
                rrr.hidden = NO;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
            }
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.goods_list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.goods_list.count) {
                    
                    [arr addObjectsFromArray:list.data.goods_list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([nowType isEqualToString:@"无界预购"] ) {
        waterfall.columnCount = 2;

        SMerchantPreList * list = [[SMerchantPreList alloc] init];
        list.merchant_id = _merchant_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantPreListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SMerchantPreList * list = (SMerchantPreList *)data;
            if ([list.data.is_collect integerValue] == 0) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            }
            
            merchant_name = list.data.merchant_name;
            logo = list.data.logo;
            merchant_slogan = list.data.merchant_slogan;
            announce = list.data.announce;
            ticket_num = list.data.ticket_num;
            ticket_list = list.data.ticket_list;
            
            
            top.merchant_name.text = merchant_name;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.topContent.text = merchant_slogan;
            top.noticeTitle.text = announce;
            rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
            if ([ticket_num integerValue] == 0) {
                rrr.hidden = YES;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);
            } else {
                rrr.hidden = NO;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
            }
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.goods_list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.goods_list.count) {
                    
                    [arr addObjectsFromArray:list.data.goods_list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([nowType isEqualToString:@"竞拍汇"] ) {
        waterfall.columnCount = 2;

        SMerchantAuctionList * list = [[SMerchantAuctionList alloc] init];
        list.merchant_id = _merchant_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantAuctionListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SMerchantAuctionList * list = (SMerchantAuctionList *)data;
            if ([list.data.is_collect integerValue] == 0) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            }
            
            merchant_name = list.data.merchant_name;
            logo = list.data.logo;
            merchant_slogan = list.data.merchant_slogan;
            announce = list.data.announce;
            ticket_num = list.data.ticket_num;
            ticket_list = list.data.ticket_list;
            
            
            top.merchant_name.text = merchant_name;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.topContent.text = merchant_slogan;
            top.noticeTitle.text = announce;
            rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
            if ([ticket_num integerValue] == 0) {
                rrr.hidden = YES;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);
            } else {
                rrr.hidden = NO;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
            }
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.goods_list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.goods_list.count) {
                    
                    [arr addObjectsFromArray:list.data.goods_list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([nowType isEqualToString:@"积分夺宝"] ) {
        waterfall.columnCount = 2;

        SMerchantOneBuyList * list = [[SMerchantOneBuyList alloc] init];
        list.merchant_id = _merchant_id;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantOneBuyListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SMerchantOneBuyList * list = (SMerchantOneBuyList *)data;
            if ([list.data.is_collect integerValue] == 0) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            }
            
            merchant_name = list.data.merchant_name;
            logo = list.data.logo;
            merchant_slogan = list.data.merchant_slogan;
            announce = list.data.announce;
            ticket_num = list.data.ticket_num;
            ticket_list = list.data.ticket_list;
            
            
            top.merchant_name.text = merchant_name;
            [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            top.topContent.text = merchant_slogan;
            top.noticeTitle.text = announce;
            rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
            if ([ticket_num integerValue] == 0) {
                rrr.hidden = YES;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100);
            } else {
                rrr.hidden = NO;
                [waterfall sectionInset:UIEdgeInsetsMake(170 + 100 + 70, 0, 5, 0)];
                top.frame = CGRectMake(0, 0, ScreenW, 170 + 100 + 70);
            }
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.goods_list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.goods_list.count) {
                    
                    [arr addObjectsFromArray:list.data.goods_list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
#pragma mark - 公告
- (void)noticeBtnClick {
    coup = [[SLineShop_infor_CouponView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:coup];
    coup.thisTitle.text = @"活动公告";
    [coup showNotice:announce];
    coup.SLineShop_infor_CouponView_Back = ^{
        [coup removeFromSuperview];
    };
}
#pragma mark - 选择类型
- (void)choiceClick:(UIButton *)btn {
    if (btn.tag == 1) {
        [top removeFromSuperview];
        top = [[SOnlineShopInfor_Top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 170 + 100 + 70)];
        _mTable.tableHeaderView = top;
        top.searchTF.text = thisSearchGoods;
        [top.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];

        top.merchant_name.text = merchant_name;
        [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        top.topContent.text = merchant_slogan;
        top.noticeTitle.text = announce;

        __block SOnlineShopInfor * gSelf = self;
        rrr = [[SLineShop_infor_Left_subCon_R alloc] initWithFrame:CGRectMake(0, 170 + 100, ScreenW, 70)];
        [top addSubview:rrr];
        rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
        rrr.SLineShop_infor_Left_subCon_R_show = ^{
            coup = [[SLineShop_infor_CouponView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [[[UIApplication sharedApplication] keyWindow] addSubview:coup];
            [coup showModel:ticket_list];
            coup.SLineShop_infor_CouponView_Back = ^{
                [coup removeFromSuperview];
            };
            coup.SLineShop_infor_CouponView_get = ^(NSString *ticket_id) {
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                    [coup removeFromSuperview];
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
                    [coup removeFromSuperview];
                    if ([code isEqualToString:@"1"]) {
                        [coup removeFromSuperview];
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
            
        };
        _mTable.hidden = NO;
        _mCollect.hidden = YES;
        [top type:@"1"];
        //店铺信息
        [top.topShopBtn addTarget:self action:@selector(topShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [top.noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [top.oneBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.twoBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.threeBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.fourBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.fiveBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [top.oneBtn setTag:1];
        [top.twoBtn setTag:2];
        [top.threeBtn setTag:3];
        [top.fourBtn setTag:4];
        [top.fiveBtn setTag:5];
        
        nowType = @"店铺首页";
        thisSearchGoods = @"";
        top.searchTF.text = @"";
        page = 1;
        [self initRefresh];
        [self showModel];

    } else {
        [top removeFromSuperview];
        top = [[SOnlineShopInfor_Top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 170 + 100 + 70)];
        [_mCollect addSubview:top];
        top.searchTF.text = thisSearchGoods;
        [top.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];

        top.merchant_name.text = merchant_name;
        [top.headerImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        top.topContent.text = merchant_slogan;
        top.noticeTitle.text = announce;

        __block SOnlineShopInfor * gSelf = self;
        rrr = [[SLineShop_infor_Left_subCon_R alloc] initWithFrame:CGRectMake(0, 170 + 100, ScreenW, 70)];
        [top addSubview:rrr];
        rrr.ticket_num.text = [NSString stringWithFormat:@"流转商品中有%@张优惠券可领取",ticket_num];
        
        rrr.SLineShop_infor_Left_subCon_R_show = ^{
            coup = [[SLineShop_infor_CouponView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [[[UIApplication sharedApplication] keyWindow] addSubview:coup];
            [coup showModel:ticket_list];
            coup.SLineShop_infor_CouponView_Back = ^{
                [coup removeFromSuperview];
            };
            coup.SLineShop_infor_CouponView_get = ^(NSString *ticket_id) {
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                    [coup removeFromSuperview];
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
                    [coup removeFromSuperview];
                    if ([code isEqualToString:@"1"]) {
                        [coup removeFromSuperview];
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
        };
        _mTable.hidden = YES;
        _mCollect.hidden = NO;
        [top type:[NSString stringWithFormat:@"%ld",btn.tag]];
        //店铺信息
        [top.noticeBtn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [top.topShopBtn addTarget:self action:@selector(topShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [top.oneBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.twoBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.threeBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.fourBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.fiveBtn addTarget:self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [top.oneBtn setTag:1];
        [top.twoBtn setTag:2];
        [top.threeBtn setTag:3];
        [top.fourBtn setTag:4];
        [top.fiveBtn setTag:5];
        
        if (btn.tag == 2) {
            page = 1;
            nowType = @"全部商品";
            [self initRefresh];
            [self showModel];
        }
        if (btn.tag == 3) {
            page = 1;
            thisSearchGoods = @"";
            top.searchTF.text = @"";
            nowType = @"热销商品";
            [self initRefresh];
            [self showModel];
        }
        if (btn.tag == 4) {
            page = 1;
            thisSearchGoods = @"";
            top.searchTF.text = @"";
            nowType = @"最新上架";
            [self initRefresh];
            [self showModel];
        }
        
#pragma mark - 活动商品
        if (btn.tag == 5) {
            thisSearchGoods = @"";
            top.searchTF.text = @"";
            classView.mCollect_HHH.constant = 170 + 100 - class_HHH;
            classView.hidden = NO;
            
        }
    }
}
#pragma mark - 店铺信息
- (void)topShopBtnClick {
    SLineShop_inforSub * inforSub = [[SLineShop_inforSub alloc] init];
    inforSub.type = YES;
    inforSub.merchant_id = _merchant_id;
    inforSub.merchant_name = merchant_name;
    [self.navigationController pushViewController:inforSub animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    adjustsScrollViewInsets_NO(_mCollect, self);
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    [self scrollViewDidScroll:_mTable];
    [self scrollViewDidScroll:_mCollect];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    class_HHH = offsetY;
    if (offsetY > NAVBAR_CHANGE_POINT) {
                CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
                [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //                home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
        self.title = merchant_name;
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
    } else {
        self.title = @"";
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
//    //获取tableView当前的y偏移
//    CGFloat contentOffsety  = scrollView.contentOffset.y;
//    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
//    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
//        _mTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
//    else if(contentOffsety>=200-64){
//        _mTable.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
//    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItems = @[leftBtnItem];
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"白色分享"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(-3, 20, 10, 0);
    rightBtn_sub.titleEdgeInsets = UIEdgeInsetsMake( 0,-10,-21, 0);
    
    rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn_sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    nagetiveSpacer.width = -15;//这个值可以根据自己需要自己调整
    self.navigationItem.rightBarButtonItems = @[nagetiveSpacer,rightBtnItem,rightBtnItem_sub];
}
- (void)lefthBtnClick {
    BOOL isExit=NO;
    for(UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:[WAInRoom class]]){
            isExit=YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        }
        
    }
    if(isExit==NO)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}
#pragma mark - 分享
- (void)rightBtnClick {
//    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//    backGroundView.backgroundColor = WordColor_sub_sub_sub;
//    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [self.view addSubview:view];
    
    AShare * shareVC = [[AShare alloc] init];
//    shareVC.thisUrl = share_url;
    shareVC.thisUrl = SharedWapStoreUrl(_merchant_id);
    shareVC.thisImage = share_img;
    shareVC.thisTitle = merchant_name;
    shareVC.thisContent = share_content;
    shareVC.thisType = @"2";
    shareVC.id_val = _merchant_id;
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
//        [backGroundView removeFromSuperview];
//        [view removeFromSuperview];
    };
}
#pragma mark - 收藏
- (void)rightBtn_subClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [self showModel];
        };
        return;
    }
    if (collect_isno == NO) {
        SUserCollectAddCollect * collect = [[SUserCollectAddCollect alloc] init];
        collect.type = @"2";
        collect.id_val = _merchant_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [collect sUserCollectAddCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [rightBtn_sub setImage:[UIImage imageNamed:@"收藏红"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                });
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else {
        SUserCollectDelOneCollect * delCollect = [[SUserCollectDelOneCollect alloc] init];
        delCollect.type = @"2";
        delCollect.id_val = _merchant_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [delCollect sUserCollectDelOneCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [rightBtn_sub setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
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
    return ScreenW/1242*828;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SOnlineShopInforCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SOnlineShopInforCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SMerchantMerIndex * list = arr[indexPath.section];
    [cell.ads_pic sd_setImageWithURL:[NSURL URLWithString:list.ads_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMerchantMerIndex * list = arr[indexPath.section];
    if (list.goods_id != nil && ![list.goods_id isEqualToString:@""] && ![list.goods_id isEqualToString:@"0"]) {
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (list.href != nil && ![list.href isEqualToString:@""] && ![list.href isEqualToString:@"0"]) {
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = list.href;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }

}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    if ([nowType isEqualToString:@"全部商品"] || [nowType isEqualToString:@"热销商品"] || [nowType isEqualToString:@"最新上架"]) {
        return ScreenW/2 - 2.5 + 40 + 30 + 30 + 40;
    }
    if ([nowType isEqualToString:@"限量购"]) {
        return ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40;
    }
    if ([nowType isEqualToString:@"拼团购"]) {
//        return ScreenW/2 - 2.5 + 170 + 40;
        /*
         *隐藏掉单买价后的item的高度
         */
        return ScreenW/2 - 2.5 + 150 + 40;
    }
    if ([nowType isEqualToString:@"无界预购"]) {
        return ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40;
    }
    if ([nowType isEqualToString:@"竞拍汇"]) {
        return ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 40;
    }
    if ([nowType isEqualToString:@"积分夺宝"]) {
        return ScreenW/2 - 2.5 + 40 + 30 + 30 + 40;
    }
    return 0.01;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([nowType isEqualToString:@"拼团购"]) {
        SOnlineShopCell_2 *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell_2" forIndexPath:indexPath];
        
        SMerchantGroupList * list = arr[indexPath.row];
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        NSLog(@"看图样子:%@",list.goods_img);
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_title.backgroundColor = WordColor_sub_sub;
            mCell.top_title.text = @"不可使用代金券";
        } else {
            mCell.top_title.backgroundColor = [UIColor orangeColor];
            mCell.top_title.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        /*
         *设置国旗图标的显示
         */
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        /*
         *显示体验拼单商品的标识符
         */
        if ([list.group_type isEqualToString:@"1"]) {
            //            NSLog(@"试用品拼单");
            mCell.onTrialTipImageView.hidden = NO;
        }else{
            mCell.onTrialTipImageView.hidden = YES;
        }
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goods_name.text = list.goods_name;
        mCell.group_price.text = [NSString stringWithFormat:@"￥%@",list.group_price];
        mCell.simple_num.text = [NSString stringWithFormat:@"(%@人拼单价)",list.group_num];
        
        /*
         *不显示单买价
         *将simple_proce的高度约束设置为0
         */
//        mCell.simple_proce.text = [NSString stringWithFormat:@"单买价:￥%@",list.shop_price];
        mCell.simple_proceHeightCons.constant = 0;
        mCell.total.text = [NSString stringWithFormat:@"已拼:%@件",list.total];
        mCell.integral.text = list.integral;
        
        if (list.append_person.count == 0) {
            mCell.header1.hidden = YES;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 1) {
            SMerchantGroupList * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 2) {
            SMerchantGroupList * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            SMerchantGroupList * list_pic_sub = list.append_person[1];
            [mCell.header2 sd_setImageWithURL:[NSURL URLWithString:list_pic_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = NO;
        }
        
        
        return mCell;
    }
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    mCell.choiceBtn.hidden = YES;
    
    if ([nowType isEqualToString:@"全部商品"] || [nowType isEqualToString:@"热销商品"] || [nowType isEqualToString:@"最新上架"]) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = NO;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.timeView.hidden = YES;
        mCell.timeView_HHH.constant = 0;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SMerchantGoodsList * list = arr[indexPath.row];

        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
    }
    if ([nowType isEqualToString:@"限量购"]) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.time_submit.hidden = YES;//提醒我
        
        //        mCell.blue_Num.text = @"已抢购19件";
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = NO;
        mCell.blueView_HHH.constant = 30;//30
        
        SMerchantLimitList * list = arr[indexPath.row];

        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.limit_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
        mCell.model = arr[indexPath.row];
        [mCell.blue_pro setProgress:[list.sell_num floatValue]/([list.sell_num floatValue] + [list.limit_store floatValue])];
        mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/([list.sell_num floatValue] + [list.limit_store floatValue]) * 100];
    }
    
    if ([nowType isEqualToString:@"无界预购"]) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.time_submit.hidden = YES;//提醒我
        mCell.blue_Num.text = @"已预购100件";
        
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = NO;
        mCell.blueView_HHH.constant = 30;//30
        
        SMerchantPreList * list = arr[indexPath.row];

        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.deposit];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
        mCell.model = arr[indexPath.row];
        [mCell.blue_pro setProgress:[list.sell_num floatValue]/([list.sell_num floatValue] + [list.pre_store floatValue])];
        mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/([list.sell_num floatValue] + [list.pre_store floatValue]) * 100];
    }
    if ([nowType isEqualToString:@"竞拍汇"]) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.time_submit.hidden = YES;//提醒我
        
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SMerchantAuctionList * list = arr[indexPath.row];

        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.start_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        
        mCell.model = arr[indexPath.row];
    }
    if ([nowType isEqualToString:@"积分夺宝"]) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = YES;
        mCell.goods_priceHHH.constant = 0;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = NO;
        mCell.redView_HHH.constant = 30;//30
        
        mCell.timeView.hidden = YES;
        mCell.timeView_HHH.constant = 0;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SMerchantOneBuyList * list = arr[indexPath.row];

        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        [mCell.red_pro setProgress:(1 - [list.diff_num floatValue]/[list.person_num floatValue])];
        mCell.red_num.text = [NSString stringWithFormat:@"总需%@人次",list.person_num];
        mCell.red_numSub.text = list.diff_num;
        mCell.integral_price.text = list.integral;
    }
    
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([nowType isEqualToString:@"全部商品"] || [nowType isEqualToString:@"热销商品"] || [nowType isEqualToString:@"最新上架"]) {
        SMerchantGoodsList * list = arr[indexPath.row];

        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.goods_id;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
//        SGoodsInfor * info = [[SGoodsInfor alloc] init];
//        info.goods_type = @"商品详情";
//        info.goods_id = list.goods_id;
//        info.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    
    if ([nowType isEqualToString:@"限量购"]) {
        
        SMerchantLimitList * list = arr[indexPath.row];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.limit_buy_id;
        info.overType = @"限量购";
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
    if ([nowType isEqualToString:@"拼团购"]) {
        SMerchantGroupList * list = arr[indexPath.row];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.group_buy_id;
        info.overType = @"拼单购";
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
    if ([nowType isEqualToString:@"无界预购"]) {
        SMerchantPreList * list = arr[indexPath.row];
        
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.pre_buy_id;
        info.overType = @"无界预购";
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    }
    if ([nowType isEqualToString:@"竞拍汇"]) {
        SMerchantAuctionList * list = arr[indexPath.row];
        
        SLotInfor * lot = [[SLotInfor alloc] init];
        lot.auction_id = list.auction_id;
        lot.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lot animated:YES];
    }
    if ([nowType isEqualToString:@"积分夺宝"]) {
        SMerchantOneBuyList * list = arr[indexPath.row];
        
        SIndianaInfor * infor = [[SIndianaInfor alloc] init];
        infor.one_buy_id = list.one_buy_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
    }
}

//返回上一层
- (void)goBack {
    [self.navigationController popViewControllerAnimated:TRUE];
}
@end
