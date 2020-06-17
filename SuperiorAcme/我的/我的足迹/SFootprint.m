//
//  SFootprint.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SFootprint.h"
#import "SGoodsInfor_nav.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell.h"
#import "SSearch_contentCell.h"
#import "SGoodsInfor.h"
#import "SCollectBookCell.h"

#import "SUserMyfooter.h"
#import "CQPlaceholderView.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"
#import "SUserCollectCollectList.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"
#import "SUserCollectDelCollect.h"
#import "SUserDelFooter.h"
#import "SGoodsInfor_first.h"
#import "UBNearByShopCell.h"
#import "UBShopDetailController.h"
#import "SlineDetailWebController.h"
@interface SFootprint () <XRWaterfallLayoutDelegate,CQPlaceholderViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    SGoodsInfor_nav * nav;
    UIButton * rigthBtn;
    BOOL edit_isno;//NO默认 YES编辑
    BOOL allBtn_isno;//NO未全选中 YES全选中
    
    NSString * thisType;//类型参数 1商品（默认） 2店铺 3书院
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView *placeholderView1;
    CQPlaceholderView *placeholderView2;
    CQPlaceholderView *placeholderView3;
    CQPlaceholderView *placeholderView4;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UITableView *threeTable;
@property (weak, nonatomic) IBOutlet UITableView *fourTable;

@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mCollect_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mTable_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *threeTable_HHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourTable_HHH;

@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@property (strong, nonatomic) IBOutlet UIButton *delBtn;
@end

@implementation SFootprint

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    XRWaterfallLayout * waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(0, 0, 5, 0)];
    waterfall.delegate = self;
    _mCollect.collectionViewLayout = waterfall;
    
    placeholderView1 = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView1];
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SSearch_contentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SSearch_contentCell"];
    _threeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_threeTable registerNib:[UINib nibWithNibName:@"SCollectBookCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SCollectBookCell"];
    
    _fourTable.separatorStyle = 0;
    [_fourTable registerNib:[UINib nibWithNibName:[UBNearByShopCell cellIdentifer] bundle:nil] forCellReuseIdentifier:[UBNearByShopCell cellIdentifer]];
    _fourTable.estimatedRowHeight = 100;
    _fourTable.rowHeight = UITableViewAutomaticDimension;
    
    placeholderView2 = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView2];
    
    placeholderView3 = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_threeTable addSubview:placeholderView3];
    
    placeholderView4 = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_fourTable addSubview:placeholderView4];
    
    //多选
    [_allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //删除
    [_delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //默认商品
    _mCollect.hidden = NO;
    _mTable.hidden = YES;
    _threeTable.hidden = YES;
    _fourTable.hidden = YES;
    _downView.hidden = YES;
    thisType = @"1";
    page = 1;
    [self initRefresh];
    [self showModel];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    adjustsScrollViewInsets_NO(_mCollect, self);
    adjustsScrollViewInsets_NO(_threeTable, self);
    adjustsScrollViewInsets_NO(_fourTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
}
- (void)initRefresh
{
    __block SFootprint * blockSelf = self;
    if ([thisType isEqualToString:@"1"]) {
        _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    }
    if ([thisType isEqualToString:@"2"]) {
        _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    }
    if ([thisType isEqualToString:@"3"]) {
        _threeTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _threeTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    }
    
    if ([thisType isEqualToString:@"5"]) {
        _fourTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _fourTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    if (_type == NO) {
        SUserMyfooter * list = [[SUserMyfooter alloc] init];
        list.type = thisType;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserMyfooterSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SUserMyfooter * list = (SUserMyfooter *)data;
            
            if ([thisType isEqualToString:@"1"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_mCollect.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_mCollect.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_mCollect.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_mCollect.mj_header endRefreshing];
                [_mCollect reloadData];
            }
            if ([thisType isEqualToString:@"2"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_mTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_mTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_mTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_mTable.mj_header endRefreshing];
                [_mTable reloadData];
            }
            if ([thisType isEqualToString:@"3"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_threeTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_threeTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_threeTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_threeTable.mj_header endRefreshing];
                [_threeTable reloadData];
            }
            
            //5
            if ([thisType isEqualToString:@"5"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_fourTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_fourTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_fourTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_fourTable.mj_header endRefreshing];
                [_fourTable reloadData];
            }
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        
        SUserCollectCollectList * list = [[SUserCollectCollectList alloc] init];
        list.type = thisType;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserCollectCollectListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SUserCollectCollectList * list = (SUserCollectCollectList *)data;
            
            if ([thisType isEqualToString:@"1"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_mCollect.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_mCollect.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_mCollect.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_mCollect.mj_header endRefreshing];
                [_mCollect reloadData];
            }
            if ([thisType isEqualToString:@"2"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_mTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_mTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_mTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_mTable.mj_header endRefreshing];
                [_mTable reloadData];
            }
            if ([thisType isEqualToString:@"3"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_threeTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_threeTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_threeTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_threeTable.mj_header endRefreshing];
                [_threeTable reloadData];
            }
            
            if ([thisType isEqualToString:@"5"]) {
                if (page == 1) {
                    arr = [NSMutableArray arrayWithArray:list.data];
                    [_fourTable.mj_footer resetNoMoreData];
                } else {
                    if (list.data.count) {
                        
                        [arr addObjectsFromArray:list.data];
                        [_fourTable.mj_footer endRefreshing];
                        
                    } else {
                        
                        [_fourTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [_fourTable.mj_header endRefreshing];
                [_fourTable reloadData];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
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
    
    nav = [[SGoodsInfor_nav alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
    self.navigationItem.titleView = nav;
    nav.twoBtn_WWW.constant = 240 / 4.0;
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    nav.FourLine.hidden = YES;
    
    //商品
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.oneBtn setTitle:@"商品" forState:UIControlStateNormal];
    [nav.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //商家
    [nav.twoBtn setTitle:@"商家" forState:UIControlStateNormal];
    [nav.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //书院
    [nav.threeBtn setTitle:@"书院" forState:UIControlStateNormal];
    [nav.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [nav.FourBtn addTarget:self
                    action:@selector(FourBtnClick)
          forControlEvents:1<<6];
    
    nav.isCollectOrFooter = YES;
    nav.FourBtn.hidden = NO;
    
    rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    if (edit_isno == NO) {
        [rigthBtn setTitle:@"完成" forState:UIControlStateNormal];
        edit_isno = YES;
        _downView.hidden = NO;
        _mCollect_HHH.constant = 50;
        _mTable_HHH.constant = 50;
        _threeTable_HHH.constant = 50;
        _fourTable_HHH.constant = 50;
    } else {
        [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
        edit_isno = NO;
        _downView.hidden = YES;
        _mCollect_HHH.constant = 0;
        _mTable_HHH.constant = 0;
        _threeTable_HHH.constant = 0;
        _fourTable_HHH.constant = 0;
    }
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
    [_fourTable reloadData];
}
#pragma mark - 商品
- (void)oneBtnClick {
    [nav.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.FourBtn setTitleColor:WordColor forState:0];
    nav.oneLine.hidden = NO;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    nav.FourLine.hidden = YES;
    
    _mCollect.hidden = NO;
    _mTable.hidden = YES;
    _threeTable.hidden = YES;
    _fourTable.hidden = YES;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
    _downView.hidden = YES;
    _mCollect_HHH.constant = 0;
    _mTable_HHH.constant = 0;
    _threeTable_HHH.constant = 0;
    _fourTable_HHH.constant = 0;
    
    page = 1;
    thisType = @"1";
    [self initRefresh];
    [self showModel];
}
#pragma mark - 商家
- (void)twoBtnClick {
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.FourBtn setTitleColor:WordColor forState:0];
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = NO;
    nav.threeLine.hidden = YES;
    nav.FourLine.hidden = YES;
    
    _mCollect.hidden = YES;
    _mTable.hidden = NO;
    _threeTable.hidden = YES;
    _fourTable.hidden = YES;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
    _downView.hidden = YES;
    _mCollect_HHH.constant = 0;
    _mTable_HHH.constant = 0;
    _threeTable_HHH.constant = 0;
    _fourTable_HHH.constant = 0;
    
    page = 1;
    thisType = @"2";
    [self initRefresh];
    [self showModel];
}
#pragma mark - 书院
- (void)threeBtnClick {
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.FourBtn setTitleColor:WordColor forState:0];
    [nav.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = NO;
    nav.FourLine.hidden = YES;
    
    _mCollect.hidden = YES;
    _mTable.hidden = YES;;
    _threeTable.hidden = NO;
    _fourTable.hidden = YES;
    
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
    _downView.hidden = YES;
    _mCollect_HHH.constant = 0;
    _mTable_HHH.constant = 0;
    _threeTable_HHH.constant = 0;
    _fourTable_HHH.constant = 0;
    
    page = 1;
    thisType = @"3";
    [self initRefresh];
    [self showModel];
}

-(void)FourBtnClick{
    [nav.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [nav.FourBtn setTitleColor:[UIColor redColor] forState:0];
    
    nav.oneLine.hidden = YES;
    nav.twoLine.hidden = YES;
    nav.threeLine.hidden = YES;
    nav.FourLine.hidden = NO;
    
    _mCollect.hidden = YES;
    _mTable.hidden = YES;;
    _threeTable.hidden = YES;
    _fourTable.hidden = NO;
    //显示
    [rigthBtn setTitle:@"编辑" forState:UIControlStateNormal];
    edit_isno = NO;
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
    [_fourTable reloadData];
    _downView.hidden = YES;
    _mCollect_HHH.constant = 0;
    _mTable_HHH.constant = 0;
    _threeTable_HHH.constant = 0;
    _fourTable_HHH.constant = 0;
    
    page = 1;
    thisType = @"5";
    [self initRefresh];
    [self showModel];
}

#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (arr.count == 0) {
        placeholderView1.hidden = NO;
        rigthBtn.hidden = YES;
        _downView.hidden = YES;
        _mCollect_HHH.constant = 0;
        _mTable_HHH.constant = 0;
        _threeTable_HHH.constant = 0;
    } else {
        placeholderView1.hidden = YES;
        rigthBtn.hidden = NO;
    }
    return arr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    return ScreenW/2 - 2.5 + 40 + 30 + 30 + 40;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    if (edit_isno == NO) {
        mCell.choiceBtn.hidden = YES;
    } else {
        mCell.choiceBtn.hidden = NO;
    }
    [mCell.choiceBtn setTag:indexPath.row];
    [mCell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    if (_type == NO) {
        SUserMyfooter * list = arr[indexPath.row];
        if (list.choice_isno == NO) {
            [mCell.choiceBtn setImage:[UIImage imageNamed:@"白色对钩"] forState:UIControlStateNormal];
        } else {
            [mCell.choiceBtn setImage:[UIImage imageNamed:@"红色对钩"] forState:UIControlStateNormal];
        }

        
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认张方形"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
    } else {
        
        SUserCollectCollectList * list = arr[indexPath.row];
        if (list.choice_isno == NO) {
            [mCell.choiceBtn setImage:[UIImage imageNamed:@"白色对钩"] forState:UIControlStateNormal];
        } else {
            [mCell.choiceBtn setImage:[UIImage imageNamed:@"红色对钩"] forState:UIControlStateNormal];
        }

        
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认张方形"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
    }
    
    
    
    return mCell;
}
- (void)choiceBtnClick:(UIButton *)btn {
    if (_type == NO) {
        SUserMyfooter * list = arr[btn.tag];
        if (list.choice_isno == NO) {
            list.choice_isno = YES;
        } else {
            list.choice_isno = NO;
        }
        if ([self choiceR] == NO) {
            [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
            allBtn_isno = NO;
        } else {
            [_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            allBtn_isno = YES;
        }
    } else {
        SUserCollectCollectList * list = arr[btn.tag];
        if (list.choice_isno == NO) {
            list.choice_isno = YES;
        } else {
            list.choice_isno = NO;
        }
        if ([self choiceR] == NO) {
            [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
            allBtn_isno = NO;
        } else {
            [_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            allBtn_isno = YES;
        }
    }
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
     [_fourTable reloadData];
}
#pragma mark - 多选状态判断
- (BOOL)choiceR {
    if (_type == NO) {
        for (SUserMyfooter * list in arr) {
            if (list.choice_isno == NO) {
                return NO;
            }
        }
        
    } else {
        for (SUserCollectCollectList * list in arr) {
            if (list.choice_isno == NO) {
                return NO;
            }
        }
    }
    return YES;
}
#pragma mark - 多选操作
- (void)allBtnClick {
    if (_type == NO) {
        if (allBtn_isno == NO) {
            for (SUserMyfooter * list in arr) {
                list.choice_isno = YES;
            }
            [_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            allBtn_isno = YES;
        } else {
            for (SUserMyfooter * list in arr) {
                list.choice_isno = NO;
            }
            [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
            allBtn_isno = NO;
        }
        
    } else {
        if (allBtn_isno == NO) {
            for (SUserCollectCollectList * list in arr) {
                list.choice_isno = YES;
            }
            [_allBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            allBtn_isno = YES;
        } else {
            for (SUserCollectCollectList * list in arr) {
                list.choice_isno = NO;
            }
            [_allBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
            allBtn_isno = NO;
        }
        
    }
    [_mCollect reloadData];
    [_mTable reloadData];
    [_threeTable reloadData];
     [_fourTable reloadData];
}
#pragma mark - 多选删除
- (void)delBtnClick {
    
    NSMutableArray * del_arr = [[NSMutableArray alloc] init];
    if (_type == NO) {
        for (SUserMyfooter * list in arr) {
            if (list.choice_isno == YES) {
                [del_arr addObject:list.footer_id];
            }
        }
        SUserDelFooter * del = [[SUserDelFooter alloc] init];
        del.footer_ids = [del_arr componentsJoinedByString:@","];
        [MBProgressHUD showMessage:nil toView:self.view];
        [del sUserDelFooterSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    page = 1;
                    [self initRefresh];
                    [self showModel];
                    [self rigthBtnClick];
                });
            } else {
                [MBProgressHUD showError:nil toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        for (SUserCollectCollectList * list in arr) {
            if (list.choice_isno == YES) {
                [del_arr addObject:list.collect_id];
            }
        }
        SUserCollectDelCollect * del = [[SUserCollectDelCollect alloc] init];
        del.collect_ids = [del_arr componentsJoinedByString:@","];
        [MBProgressHUD showMessage:nil toView:self.view];
        [del sUserCollectDelCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    page = 1;
                    [self initRefresh];
                    [self showModel];
                    [self rigthBtnClick];

                });
            } else {
                [MBProgressHUD showError:nil toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//    info.goods_type = @"商品详情";
    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
    if (_type == NO) {
        SUserMyfooter * list = arr[indexPath.row];
        info.goods_id = list.goods_id;
    } else {
        SUserCollectCollectList * list = arr[indexPath.row];
        info.goods_id = list.goods_id;
    }
    info.overType = NULL;
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _threeTable || [tableView isEqual:_fourTable]) {
        return 1;
    }
    if (arr.count == 0) {
        placeholderView2.hidden = NO;
        rigthBtn.hidden = YES;
        _downView.hidden = YES;
        _mCollect_HHH.constant = 0;
        _mTable_HHH.constant = 0;
        _threeTable_HHH.constant = 0;
    } else {
        placeholderView2.hidden = YES;
        rigthBtn.hidden = NO;

    }
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _threeTable) {
        if (arr.count == 0) {
            placeholderView3.hidden = NO;
            rigthBtn.hidden = YES;
            _downView.hidden = YES;
            _mCollect_HHH.constant = 0;
            _mTable_HHH.constant = 0;
            _threeTable_HHH.constant = 0;
        } else {
            placeholderView3.hidden = YES;
            rigthBtn.hidden = NO;
        }
        return arr.count;
    }
    
    if([tableView isEqual:_fourTable]){
        if (arr.count == 0){
            placeholderView4.hidden = NO;
            rigthBtn.hidden = YES;
            _downView.hidden = YES;
            _mCollect_HHH.constant = 0;
            _mTable_HHH.constant = 0;
            _threeTable_HHH.constant = 0;
            _fourTable_HHH.constant = 0;
        }else{
            placeholderView4.hidden = YES;
            rigthBtn.hidden = NO;
        }
        return arr.count;
    }
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _threeTable) {
        if (section == 0) {
            return 10;
        }
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_fourTable]) {
        return UITableViewAutomaticDimension;
    }
    
    if (tableView == _threeTable) {
        return 100;
    }
    if (_type == NO) {
        SUserMyfooter * list = arr[indexPath.section];
        if (list.goodsList.count == 0) {
            return 100;
        }
    } else {
        
        SUserCollectCollectList * list = arr[indexPath.section];
        if (list.merchantFace.goodsList.count == 0) {
            return 100;
        }

    }
    return 230;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([tableView isEqual:_fourTable]) {
        UBNearByShopCell *aCell = [tableView dequeueReusableCellWithIdentifier:[UBNearByShopCell cellIdentifer] forIndexPath:indexPath];
        
        if (edit_isno == NO) {
            aCell.choiceBtn.hidden = YES;
        } else {
            aCell.choiceBtn.hidden = NO;
        }
        
        [aCell.choiceBtn setTag:indexPath.row];
        [aCell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_type == YES) { //收藏
            aCell.nearByStoreModel = arr[indexPath.row];
            SUserCollectCollectList * list = arr[indexPath.row];
            if (list.choice_isno == NO) {
                [aCell.choiceBtn setImage:[UIImage imageNamed:@"白色对钩"] forState:UIControlStateNormal];
            } else {
                [aCell.choiceBtn setImage:[UIImage imageNamed:@"红色对钩"] forState:UIControlStateNormal];
            }
        }else{
            SUserMyfooter * list = arr[indexPath.row];
            if (list.choice_isno == NO) {
                [aCell.choiceBtn setImage:[UIImage imageNamed:@"白色对钩"] forState:UIControlStateNormal];
            } else {
                [aCell.choiceBtn setImage:[UIImage imageNamed:@"红色对钩"] forState:UIControlStateNormal];
            }
             aCell.nearByStoreModel = arr[indexPath.row];
        }
        
        return aCell;
    }
    
    if (tableView == _threeTable) {
        SCollectBookCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCollectBookCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (edit_isno == NO) {
            cell.choiceBtn.hidden = YES;
            cell.headerImage_WWW.constant = 10;
            cell.line_WWW.constant = 10;
        } else {
            cell.choiceBtn.hidden = NO;
            cell.headerImage_WWW.constant = 40;
            cell.line_WWW.constant = 40;
        }
        [cell.choiceBtn setTag:indexPath.row];
        [cell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_type == NO) {
            SUserMyfooter * list = arr[indexPath.row];
            if (list.choice_isno == NO) {
                [cell.choiceBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
            } else {
                [cell.choiceBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            }
            [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.thisTitle.text = list.title;
            cell.page_views_collect_num.text = [NSString stringWithFormat:@"%@人收藏     %@人浏览",list.collect_num,list.page_views];
        } else {
            
            SUserCollectCollectList * list = arr[indexPath.row];
            if (list.choice_isno == NO) {
                [cell.choiceBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
            } else {
                [cell.choiceBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            }
            [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            cell.thisTitle.text = list.title;
            cell.page_views_collect_num.text = [NSString stringWithFormat:@"%@人收藏     %@人浏览",list.collect_num,list.page_views];
        }
        
        
        return cell;
    }
    SSearch_contentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SSearch_contentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (edit_isno == NO) {
        cell.choiceBtn.hidden = YES;
    } else {
        cell.choiceBtn.hidden = NO;
    }
    [cell.choiceBtn setTag:indexPath.section];
    [cell.choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goShopBtn addTarget:self action:@selector(goShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goShopBtn setTag:indexPath.section];
    
    if (_type == NO) {
        SUserMyfooter * list = arr[indexPath.section];
        if (list.choice_isno == NO) {
            [cell.choiceBtn setImage:[UIImage imageNamed:@"白色对钩"] forState:UIControlStateNormal];
        } else {
            [cell.choiceBtn setImage:[UIImage imageNamed:@"红色对钩"] forState:UIControlStateNormal];
        }
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.merInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.merchant_name.text = list.merInfo.merchant_name;
        cell.merchant_desc.text = list.merInfo.merchant_desc;
        cell.score.text = [NSString stringWithFormat:@"评分 %@分",list.merInfo.score];
        
        SOnlineShop_ClassInfoList_more_footerCont * con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 119)];
        [cell.classView addSubview:con];
        [con showModel:list.goodsList andPriceShow:YES andType:@"SUserMyfooter"];
        if (list.goodsList.count == 0) {
            cell.classView.hidden = YES;
        } else {
            cell.classView.hidden = NO;
        }
        con.SOnlineShop_ClassInfoList_more_footerCont_select = ^(NSString *goods_id) {
            SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
            info.goods_id = goods_id;
            info.overType = NULL;
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
        };
    } else {
        
        SUserCollectCollectList * list = arr[indexPath.section];
        if (list.choice_isno == NO) {
            [cell.choiceBtn setImage:[UIImage imageNamed:@"白色对钩"] forState:UIControlStateNormal];
        } else {
            [cell.choiceBtn setImage:[UIImage imageNamed:@"红色对钩"] forState:UIControlStateNormal];
        }
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.merchantFace.merInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.merchant_name.text = list.merchantFace.merInfo.merchant_name;
        cell.merchant_desc.text = list.merchantFace.merInfo.merchant_desc;
        cell.score.text = [NSString stringWithFormat:@"评分 %@分",list.merchantFace.merInfo.score];
        
        SOnlineShop_ClassInfoList_more_footerCont * con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 119)];
        [cell.classView addSubview:con];
        [con showModel:list.merchantFace.goodsList andPriceShow:YES andType:@"SUserCollectCollectList"];
        if (list.merchantFace.goodsList.count == 0) {
            cell.classView.hidden = YES;
        } else {
            cell.classView.hidden = NO;
        }
        con.SOnlineShop_ClassInfoList_more_footerCont_select = ^(NSString *goods_id) {
            SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
            info.goods_id = goods_id;
            info.overType = NULL;
            info.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info animated:YES];
        };
    }
    
    
    return cell;
}
- (void)goShopBtnClick:(UIButton *)btn {
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    if (_type == NO) {
        SUserMyfooter * list = arr[btn.tag];
        infor.merchant_id = list.merInfo.merchant_id;
    } else {
        
        SUserCollectCollectList * list = arr[btn.tag];
        infor.merchant_id = list.merchantFace.merInfo.merchant_id;
    }
    [self.navigationController pushViewController:infor animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _threeTable) {
        SMessageInfor * info = [[SMessageInfor alloc] init];
        if (_type == NO) {
            SUserMyfooter * list = arr[indexPath.row];
            info.academy_id = list.academy_id;

        } else {
            
            SUserCollectCollectList * list = arr[indexPath.row];
            info.academy_id = list.aid;

        }
        [self.navigationController pushViewController:info animated:YES];
    }
    if (tableView == _fourTable) {
      
        if (_type == NO) {
              SUserMyfooter * list = arr[indexPath.row];
            if ([list.goods_num integerValue] >0 ) {
   
                [self WebDetailClickWithSid:list.s_id];
          
                
            }
            else
            {
                UBShopDetailController *detailVC = [UBShopDetailController instanceWithMerchant_id:list.s_id];
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }

        } else {
          SUserCollectCollectList * list = arr[indexPath.row];
            if ([list.goods_num integerValue] >0 ) {
                
                [self WebDetailClickWithSid:list.s_id];
                
            }
            else
            {
                UBShopDetailController *detailVC = [UBShopDetailController instanceWithMerchant_id:list.s_id];
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
      
    }
}
- (void)WebDetailClickWithSid:(NSString *)sid {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
        };
        return;
    }
    else
    {
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length==0) {
            invite_code=@"";
        }
        
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/os_type/1", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        
        NSString *urlStr=nil;
        
        if (invite_code.length>0) {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@/invite_code/%@.html",detail_Base_url,sid,invite_code];
        }
        else
        {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@.html",detail_Base_url,sid];
        }
        
        
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.urlStr=urlStr;
        conter.fag=@"3";
        conter.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:conter animated:YES];
    }
}
@end
