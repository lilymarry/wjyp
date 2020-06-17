//
//  SBuildShop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBuildShop.h"
#import "SNBannerView.h"
#import "SOnlineShopCell.h"
#import "SBuildShopView.h"
#import "SHouseInfor.h"
#import "SHouseBuyHouseList.h"
#import "CQPlaceholderView.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface SBuildShop () <SNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CQPlaceholderViewDelegate,BMKLocationServiceDelegate>
{
    SBuildShopView * buildType;
    
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * model_lng;//经度
    NSString * model_lat;//纬度
    NSString * sort;//综合排序(默认)
    NSString * integral_sort;//产权排序 1 正序 2倒序
    NSString * distance_sort;//距离排序 1 正序 2倒序
    NSString * price_sort;//价格 1 正序 2倒序
    
    CQPlaceholderView * placeholderView;
    
    BMKLocationService * _locService;
    
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SBuildShop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    
    
    model_lng = @"";
    model_lat = @"";
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"房产购";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    _locService.delegate = nil; // 不用时，置nil
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if ([model_lng isEqualToString:@""]) {
        model_lng = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.longitude];
        model_lat = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.latitude];
        sort = @"1";
        integral_sort = @"";
        distance_sort = @"";
        price_sort = @"";
        page = 1;
        [self initRefresh];
        [self showModel];
    } else {
        model_lng = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.longitude];
        model_lat = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.latitude];
    }
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)initRefresh
{
    __block SBuildShop * blockSelf = self;
    _mCollect.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mCollect.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    SHouseBuyHouseList * list = [[SHouseBuyHouseList alloc] init];
    list.lng = model_lng;
    list.lat = model_lat;
    list.sort = sort;
    list.integral_sort = integral_sort;
    list.distance_sort = distance_sort;
    list.price_sort = price_sort;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sHouseBuyHouseListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SHouseBuyHouseList * list = (SHouseBuyHouseList *)data;
        
        NSMutableArray * adsArr = [[NSMutableArray alloc] init];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:list.data.ads.picture forKey:@"picture"];
        url_merchant_id = list.data.ads.merchant_id;
        url_goods_id = list.data.ads.goods_id;
        url_href = list.data.ads.href;
        [adsArr addObject:dic];
        
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self model:adsArr URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [_mCollect addSubview:banner];
        
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.car_list];
            [_mCollect.mj_footer resetNoMoreData];
        } else {
            if (list.data.car_list.count) {
                
                [arr addObjectsFromArray:list.data.car_list];
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
    
//    SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/14*5) delegate:self imageNames:@[@"首页header夏日冰爽",@"首页header夏日冰爽",@"首页header夏日冰爽"] currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
//    [_mCollect addSubview:banner];
    
    buildType = [[SBuildShopView alloc] initWithFrame:CGRectMake(0, ScreenW/1242*400, ScreenW, 40)];
    [_mCollect addSubview:buildType];
    [buildType.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [buildType.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buildType.threeBtn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buildType.fourBtn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buildType.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buildType.twoBtn setTag:0];
    [buildType.threeBtn setTag:0];
    [buildType.fourBtn setTag:0];

    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView];
    placeholderView.hidden = YES;
    
}
#pragma mark - 综合
- (void)oneBtnClick {
    [buildType.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buildType.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.twoBtn setTag:0];
    [buildType.threeBtn setTag:0];
    [buildType.fourBtn setTag:0];
    [buildType.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [buildType.threeBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [buildType.fourBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    sort = @"1";
    integral_sort = @"";
    distance_sort = @"";
    price_sort = @"";
    page = 1;
    [self showModel];

}
#pragma mark - 产权
- (void)twoBtnClick:(UIButton *)btn {
    [buildType.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buildType.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.threeBtn setTag:0];
    [buildType.fourBtn setTag:0];
    [buildType.threeBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [buildType.fourBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    
    
    if (btn.tag == 0) {
        [buildType.twoBtn setTag:1];
        [buildType.twoBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];
        sort = @"";
        integral_sort = @"2";
        distance_sort = @"";
        price_sort = @"";
    } else {
        [buildType.twoBtn setTag:0];
        [buildType.twoBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        sort = @"";
        integral_sort = @"1";
        distance_sort = @"";
        price_sort = @"";
    }
    page = 1;
    [self showModel];

}
#pragma mark - 距离
- (void)threeBtnClick:(UIButton *)btn {
    [buildType.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buildType.fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.twoBtn setTag:0];
    [buildType.fourBtn setTag:0];
    [buildType.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [buildType.fourBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    if (btn.tag == 0) {
        [buildType.threeBtn setTag:1];
        [buildType.threeBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];
        sort = @"";
        integral_sort = @"";
        distance_sort = @"2";
        price_sort = @"";
    } else {
        [buildType.threeBtn setTag:0];
        [buildType.threeBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        sort = @"";
        integral_sort = @"";
        distance_sort = @"1";
        price_sort = @"";
    }
    page = 1;
    [self showModel];

}
#pragma mark - 价格
- (void)fourBtnClick:(UIButton *)btn {
    [buildType.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [buildType.fourBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buildType.twoBtn setTag:0];
    [buildType.threeBtn setTag:0];
    [buildType.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [buildType.threeBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    if (btn.tag == 0) {
        [buildType.fourBtn setTag:1];
        [buildType.fourBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];
        sort = @"";
        integral_sort = @"";
        distance_sort = @"";
        price_sort = @"2";
    } else {
        [buildType.fourBtn setTag:0];
        [buildType.fourBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        sort = @"";
        integral_sort = @"";
        distance_sort = @"";
        price_sort = @"1";
    }
    
    page = 1;
    [self showModel];

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
    return UIEdgeInsetsMake(ScreenW/1242*400 + 40 + 5, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 90 + 60);
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    mCell.choiceBtn.hidden = YES;
    
    
    mCell.top_oneView.hidden = YES;
    mCell.top_oneView_HHH.constant = 0;//0
    mCell.top_twoView.hidden = NO;
    
    mCell.integral_num.hidden = YES;//已售xx件
    
    mCell.goods_PriceView.hidden = YES;
    mCell.goods_priceHHH.constant = 0;//30
    
    mCell.redView.hidden = YES;
    mCell.redView_HHH.constant = 0;//30
    
    mCell.carView.hidden = YES;
    mCell.carView_HHH.constant = 0;//70
    
    mCell.houseView.hidden = NO;
    mCell.houseView_HHH.constant = 90;//90
    
    mCell.timeView.hidden = YES;
    mCell.timeView_HHH.constant = 0;//30
    mCell.blueView.hidden = YES;
    mCell.blueView_HHH.constant = 0;//30
    
    mCell.goodsImage_HHH.constant = 30;//40;
    mCell.top_twoView_HHH.constant = 0;//40;
    

    
    SHouseBuyHouseList * list = arr[indexPath.row];
    NSMutableAttributedString * str_topTwo = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"此楼盘距您%@公里",list.distance]];
    [str_topTwo addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, list.distance.length)];
    mCell.top_twoTitle.attributedText = str_topTwo;
    [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.house_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.goodsTitle.text = list.house_name;
    mCell.house_titleSub.text = list.developer;
    NSMutableAttributedString * str_around = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@-%@/平",list.min_price,list.max_price]];
    [str_around addAttribute:NSForegroundColorAttributeName value:WordColor_sub range:NSMakeRange(1 + list.min_price.length + list.max_price.length, 2)];
    mCell.house_around.attributedText = str_around;
    
    NSMutableAttributedString * str_num = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"在售房源 %@套",list.now_num]];
    [str_num addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, list.now_num.length)];
    mCell.house_num.attributedText = str_num;
    
    mCell.integral_price.text = list.integral;

    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SHouseBuyHouseList * list = arr[indexPath.row];

    SHouseInfor * infor = [[SHouseInfor alloc] init];
    infor.house_id = list.house_id;
    [self.navigationController pushViewController:infor animated:YES];
}
@end
