//
//  SSearch_content.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSearch_content.h"
#import "SSearch_nav.h"
#import "CommodityMerchant.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell.h"
#import "SSearch_contentCell.h"
#import "SGoodsInfor.h"
#import "SOnlineShopInfor.h"

#import "SGoodsSearch.h"
#import "CQPlaceholderView.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"

#import "SortHeadView.h"

@interface SSearch_content () <UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate,UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate,UITextFieldDelegate>
{
    SSearch_nav * search;
    CommodityMerchant * cm;
    NSMutableArray * arr;//列表
    NSMutableArray * brr;//列表
    NSInteger  page;
    CQPlaceholderView * placeholderView1;
    CQPlaceholderView * placeholderView2;
    BOOL nowType;//NO商品 YES商家
    NSString * nowSearch;
}
@property (nonatomic, strong) SortHeadView *sortView;
@property (nonatomic, copy) NSString *searchType;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UIView *searchTypeView;


@end

@implementation SSearch_content

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    nowType = _type;
    nowSearch = _mySearch;
    [self createNav];
    [self createUI];
    _mCollect.keyboardDismissMode = 1;
    
    CGFloat topH = NAVIGATION_BAR_HEIGHT;
    
    placeholderView1 = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100 - topH, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView1];
    placeholderView1.hidden = YES;
    
    placeholderView2 = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - topH, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView2];
    placeholderView2.hidden = YES;
    
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)initRefresh
{
    __block SSearch_content * blockSelf = self;
    if (nowType == NO) {
        _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page++;
            [blockSelf showModel];
        }];
    } else {
        _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            page = 1;
            [blockSelf showModel];
            
        }];
        _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    SGoodsSearch * list = [[SGoodsSearch alloc] init];
    if (nowType == NO) {
        list.type = @"1";
    } else {
        list.type = @"2";
    }
    list.name = nowSearch;
    list.p = [@(page) stringValue];
    list.searchType = _searchType;
    list.psort = _sortView.para_order;
    list.price = _sortView.para_fliter;
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sGoodsSearchSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SGoodsSearch * list = (SGoodsSearch *)data;
        
        if (nowType == NO) {
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.list];
                [_mCollect.mj_footer resetNoMoreData];
            } else {
                if (list.data.list.count) {
                    
                    [arr addObjectsFromArray:list.data.list];
                    [_mCollect.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mCollect.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mCollect.mj_header endRefreshing];
            [_mCollect reloadData];
        } else {
            if (page == 1) {
                brr = [NSMutableArray arrayWithArray:list.data.list];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.list.count) {
                    
                    [brr addObjectsFromArray:list.data.list];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    adjustsScrollViewInsets_NO(_mCollect, self);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    cm.hidden = YES;
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
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    
    [rightBtn setImage:[UIImage imageNamed:@"红色搜索"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    search = [[SSearch_nav alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    search.layer.masksToBounds = YES;
    search.layer.cornerRadius = 3;
    self.navigationItem.titleView = search;
    [search.choiceTypeBtn addTarget:self action:@selector(choiceTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (nowType == NO) {
        [search.choiceTypeBtn setTag:0];
        [search.choiceTypeBtn setTitle:@"商品" forState:UIControlStateNormal];
        _mCollect.hidden = NO;
        _mTable.hidden = YES;
    } else {
        [search.choiceTypeBtn setTag:1];
        [search.choiceTypeBtn setTitle:@"商家" forState:UIControlStateNormal];
        _mCollect.hidden = YES;
        _mTable.hidden = NO;
    }
    search.searchTF.text = _mySearch;
    search.searchTF.delegate = self;
    
    //商品、商家 操作
    cm = [[CommodityMerchant alloc] initWithFrame:CGRectMake(70, 60, 80, 80)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:cm];
    cm.hidden = YES;
    [cm.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cm.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    nowSearch = textField.text;
    return YES;
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 商品、商家
- (void)choiceTypeBtnClick:(UIButton *)btn {
    cm.hidden = NO;
    if (btn.tag == 0) {
        [cm.oneBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [cm.twoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [cm.oneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cm.twoBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
}
#pragma mark - 选择商品
- (void)oneBtnClick {
    [search.choiceTypeBtn setTitle:@"商品" forState:UIControlStateNormal];
    [search.choiceTypeBtn setTag:0];
    cm.hidden = YES;
    _mCollect.hidden = NO;
    _mTable.hidden = YES;
    nowType = NO;
    page = 1;
    [self initRefresh];
    [self showModel];
}
#pragma mark - 选择商家
- (void)twoBtnClick {
    [search.choiceTypeBtn setTitle:@"商家" forState:UIControlStateNormal];
    [search.choiceTypeBtn setTag:1];
    cm.hidden = YES;
    _mCollect.hidden = YES;
    _mTable.hidden = NO;
    nowType = YES;
    page = 1;
    [self initRefresh];
    [self showModel];
}
#pragma mark - 搜索
- (void)rightBtnClick {
    [search.searchTF resignFirstResponder];
    if (nowType == NO) {
        _mCollect.hidden = NO;
        _mTable.hidden = YES;
    } else {
        _mCollect.hidden = YES;
        _mTable.hidden = NO;
    }
    page = 1;
    [self initRefresh];
    [self showModel];
    [self.view endEditing:YES];
}
- (void)createUI {
    
    XRWaterfallLayout * waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(0, 0, 5, 0)];
    waterfall.delegate = self;
    _mCollect.collectionViewLayout = waterfall;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SSearch_contentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SSearch_contentCell"];
    
    SortHeadView *sortView = [SortHeadView instaceWithXIB];
    [self.searchTypeView addSubview:_sortView = sortView];
    sortView.frame = sortView.superview.bounds;
    [sortView otherViewSettingWithSuperView:self.view isContenNaviHeight:YES];
    MJWeakSelf;
    _sortView.sortBlock = ^(UIButton *btn, NSString *searchType, BOOL isPriceBtn) {
            weakSelf.searchType = searchType;
            [weakSelf rightBtnClick];
    };
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (arr.count == 0) {
        placeholderView1.hidden = NO;
    } else {
        placeholderView1.hidden = YES;
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
    mCell.choiceBtn.hidden = YES;
    
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
    
    SGoodsSearch * list = arr[indexPath.row];

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
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SGoodsSearch * list = arr[indexPath.row];

    SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
    info.goods_id = list.goods_id;
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
//    SGoodsInfor * info = [[SGoodsInfor alloc] init];
//    info.goods_type = @"商品详情";
//    info.goods_id = list.goods_id;
//    info.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:info animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (brr.count == 0) {
        placeholderView2.hidden = NO;
    } else {
        placeholderView2.hidden = YES;
    }
    return brr.count;
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
    SGoodsSearch * list = brr[indexPath.section];
    if (list.goodsList.count == 0) {
        return 100;
    }
    return 230;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSearch_contentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SSearch_contentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.choiceBtn.hidden = YES;
    
    [cell.goShopBtn addTarget:self action:@selector(goShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goShopBtn setTag:indexPath.section];
    
    SGoodsSearch * list = brr[indexPath.section];
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:list.merInfo.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    cell.merchant_name.text = list.merInfo.merchant_name;
    cell.merchant_desc.text = list.merInfo.merchant_desc;
    cell.score.text = [NSString stringWithFormat:@"评分 %@分",list.merInfo.score];
    
    if (list.goodsList.count == 0) {
        cell.classView.hidden = YES;
    } else {
        cell.classView.hidden = NO;
    }
    SOnlineShop_ClassInfoList_more_footerCont * con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 119)];
    [cell.classView addSubview:con];
    [con showModel:list.goodsList andPriceShow:YES andType:@"SGoodsSearch"];
    con.SOnlineShop_ClassInfoList_more_footerCont_select = ^(NSString *goods_id) {
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
    };
    
    return cell;
}
- (void)goShopBtnClick:(UIButton *)btn {
    SGoodsSearch * list = brr[btn.tag];
    SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
    infor.merchant_id = list.merInfo.merchant_id;
    [self.navigationController pushViewController:infor animated:YES];
}
@end
