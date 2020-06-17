//
//  SCarShop_sub.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarShop_sub.h"
#import "SOnlineShopCell.h"
#import "SGoodsInfor.h"
#import "CQPlaceholderView.h"
#import "SCarBuyCarList.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface SCarShop_sub () <CQPlaceholderViewDelegate,BMKLocationServiceDelegate>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    CQPlaceholderView * placeholderView;
    NSString * model_lng;//经度
    NSString * model_lat;//纬度
    BMKLocationService * _locService;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SCarShop_sub

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
    
    self.title = @"汽车购";
    
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
    __block SCarShop_sub * blockSelf = self;
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
    SCarBuyCarList * list = [[SCarBuyCarList alloc] init];
    list.min_price = _min_price;
    list.max_price = _max_price;
    list.style_id = _style_id;
    list.brand_id = _brand_id;
    list.lng = model_lng;
    list.lat = model_lat;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sCarBuyCarListSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SCarBuyCarList * list = (SCarBuyCarList *)data;
        
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
- (void)createUI {
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView];
    placeholderView.hidden = YES;
    
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
    return UIEdgeInsetsMake( 5, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 70 + 30 + 40 + 20);
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    mCell.choiceBtn.hidden = YES;
    
    mCell.top_oneView.hidden = NO;
    mCell.top_oneView_HHH.constant = ScreenW/2 - 2.5 + 40 + 70 + 30 + 20;//0
    mCell.top_twoView.hidden = NO;
    
    mCell.integral_num.hidden = YES;//已售xx件
    
    mCell.goods_PriceView.hidden = YES;
    mCell.goods_priceHHH.constant = 0;//30
    
    mCell.redView.hidden = YES;
    mCell.redView_HHH.constant = 0;//30
    
    mCell.carView.hidden = NO;
    mCell.carView_HHH.constant = 70;//70
    
    mCell.houseView.hidden = YES;
    mCell.houseView_HHH.constant = 0;//90
    
    mCell.timeView.hidden = YES;
    mCell.timeView_HHH.constant = 0;//30
    mCell.blueView.hidden = YES;
    mCell.blueView_HHH.constant = 0;//30
    
    mCell.goodsImage_HHH.constant = 30;//40;
    mCell.top_twoView_HHH.constant = 0;//40;
    
    SCarBuyCarList * list = arr[indexPath.row];
    NSMutableAttributedString * str_topTwo = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提车地点距您%@公里",list.distance]];
    [str_topTwo addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, list.distance.length)];
    mCell.top_twoTitle.attributedText = str_topTwo;
    [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.car_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.goodsTitle.text = list.car_name;
    mCell.car_price.text = [NSString stringWithFormat:@"￥%@",list.pre_money];
    mCell.car_priceContent.text = [NSString stringWithFormat:@"可   抵：￥%@车款",list.true_pre_money];
    mCell.top_oneImage_WWW.constant = 22;

    mCell.car_priceAll.text = [NSString stringWithFormat:@"车全价：￥%@",list.all_price];
    mCell.integral_price.text = list.integral;
    [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    if ([list.ticket_discount integerValue] == 0) {
        mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
        mCell.top_oneTitle.text = @"不可使用代金券";
    } else {
        mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
        mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_discount];
    }
    
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SCarBuyCarList * list = arr[indexPath.row];

    SGoodsInfor * info = [[SGoodsInfor alloc] init];
    info.goods_type = @"汽车购";
    info.goods_id = list.car_id;
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
@end
