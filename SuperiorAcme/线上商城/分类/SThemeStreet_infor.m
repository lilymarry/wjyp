//
//  SThemeStreet_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SThemeStreet_infor.h"
#import "SOnlineShopCell.h"
#import "SNBannerView.h"
#import "SGoodsInfor.h"
#import "SThemeThemeGoods.h"
#import "CQPlaceholderView.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"

@interface SThemeStreet_infor () <UICollectionViewDelegate,UICollectionViewDataSource,SNBannerViewDelegate,CQPlaceholderViewDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView * placeholderView;
    
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SThemeStreet_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView];
    placeholderView.hidden = YES;
    
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)initRefresh
{
    __block SThemeStreet_infor * blockSelf = self;
    _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    SThemeThemeGoods * list = [[SThemeThemeGoods alloc] init];
    list.theme_id = _theme_id;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sThemeThemeGoodsSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SThemeThemeGoods * list = (SThemeThemeGoods *)data;
        
        NSMutableArray * adsArr = [[NSMutableArray alloc] init];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:list.data.theme_img forKey:@"picture"];
        url_merchant_id = list.data.merchant_id;
        url_goods_id = list.data.goods_id;
        url_href = list.data.href;
        [adsArr addObject:dic];
        
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/2) delegate:self model:adsArr URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [_mCollect addSubview:banner];
        
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
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"主题街";
    
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
- (void)createUI {
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    
    
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(ScreenW/2, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);

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
    
    SThemeThemeGoods * list = arr[indexPath.row];

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
    SThemeThemeGoods * list = arr[indexPath.row];

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
@end
