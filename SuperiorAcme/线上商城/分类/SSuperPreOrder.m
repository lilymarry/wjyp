//
//  SSuperPreOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSuperPreOrder.h"
#import "SOnlineShop_ClassView.h"
#import "SNBannerView.h"
#import "SOnlineShopCell.h"
#import "SGoodsInfor.h"
#import "SOnlineShop_InfoListView.h"
#import "SOnlineShop_ClassInfoList_sub.h"

@interface SSuperPreOrder () <UICollectionViewDelegate,UICollectionViewDataSource,SNBannerViewDelegate>
{
    SOnlineShop_InfoListView * top_class;
}
@property (strong, nonatomic) IBOutlet UIView *thisTop;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SSuperPreOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == NO) {
        self.title = @"无界预购";
    } else {
        self.title = @"韩国馆";
    }
    
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
    SOnlineShop_ClassView * top = [[SOnlineShop_ClassView alloc] initWithFrame:CGRectMake(0, 0.5, ScreenW, 40)];
    [_thisTop addSubview:top];
//    [top thisNew];
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
    top_class = [[SOnlineShop_InfoListView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200 + 10 + 0.5 + ScreenW/1242*400 - 10)];
    [_mCollect addSubview:top_class];
    
    SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self imageNames:@[@"首页header夏日冰爽",@"首页header夏日冰爽",@"首页header夏日冰爽"] currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
    [top_class.bannerView addSubview:banner];
    
    __block SSuperPreOrder * gSelf = self;
    top_class.SOnlineShop_InfoListView_select = ^(NSString *two_cate_id, NSString *short_name) {
        SOnlineShop_ClassInfoList_sub * class_sub = [[SOnlineShop_ClassInfoList_sub alloc] init];
        class_sub.two_cate_id = two_cate_id;
        class_sub.short_name = short_name;
        [gSelf.navigationController pushViewController:class_sub animated:YES];
    };
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(200 + 10 + 0.5 + ScreenW/1242*400 - 10, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == NO) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30);

    }
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30);
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    mCell.choiceBtn.hidden = YES;
    
    if (_type == NO) {
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
        
        mCell.blue_Num.text = @"已抢购19件";
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = NO;
        mCell.blueView_HHH.constant = 30;//30
    } else {
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
    }
    
    
  
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SGoodsInfor * info = [[SGoodsInfor alloc] init];
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
@end
