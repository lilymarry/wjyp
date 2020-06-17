//
//  SShopAround.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopAround.h"
#import "SShopAround_nav.h"
#import "SIndianaView.h"
#import "SOnlineShopCell.h"
#import "SShopAround_top.h"
#import "SShopAround_top_type.h"
#import "SGoodsInfor.h"

@interface SShopAround ()
{
    SShopAround_nav * search;
    SShopAround_top * top;
    UIView * groundView;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SShopAround

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色
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
    
    search = [[SShopAround_nav alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    search.layer.masksToBounds = YES;
    search.layer.cornerRadius = 3;
    self.navigationItem.titleView = search;
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 搜索
- (void)rightBtnClick {
    if ([search.searchTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入搜索内容" toView:self.view];
        return;
    }
}
- (void)createUI {
    top = [[SShopAround_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/138*31 + 40)];
    [_mCollect addSubview:top];
    [top.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top.fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [top.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [top.twoBtn setTag:0];
    
    //收藏
    [top.collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.collectBtn setTag:0];
    
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
}
#pragma mark - 收藏
- (void)collectBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [top.collectBtn setImage:[UIImage imageNamed:@"黄色桃心"] forState:UIControlStateNormal];
        [top.collectBtn setTitle:@" 已收藏" forState:UIControlStateNormal];
        [btn setTag:1];
    } else {
        [top.collectBtn setImage:[UIImage imageNamed:@"收藏白"] forState:UIControlStateNormal];
        [top.collectBtn setTitle:@" 收藏" forState:UIControlStateNormal];
        [btn setTag:0];
    }
}
#pragma mark - 人气
- (void)oneBtnClick {
    [top.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [top.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [top.twoBtn setTag:0];
    [top.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [top.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
}
#pragma mark - 价格
- (void)twoBtnClick:(UIButton *)btn {
    [top.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [top.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (btn.tag == 0) {
        [top.twoBtn setTag:1];
        [top.twoBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];
    } else {
        [top.twoBtn setTag:0];
        [top.twoBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
    }
    [top.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];

}
#pragma mark - 销量
- (void)threeBtnClick {
    [top.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [top.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [top.twoBtn setTag:0];
    [top.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [top.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
#pragma mark - 全部
- (void)fourBtnClick {
    [_mCollect setContentOffset:CGPointMake(0, 0)];

    groundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:groundView];
    groundView.backgroundColor = [UIColor clearColor];
    
    UIButton * closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64 + ScreenW/138*31 + 40 + 5, ScreenW, ScreenH - (64 + ScreenW/138*31 + 40 + 5))];
    [groundView addSubview:closeBtn];
    [closeBtn setBackgroundColor:WordColor_sub_sub];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    SShopAround_top_type * top_type = [[SShopAround_top_type alloc] initWithFrame:CGRectMake(0, 64 + ScreenW/138*31 + 40 + 5, ScreenW, 120 - 10)];
    [groundView addSubview:top_type];
}
#pragma mark - 关闭全部类型筛选
- (void)closeBtnClick {
    [groundView removeFromSuperview];
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
    return UIEdgeInsetsMake(ScreenW/138*31 + 40 + 5, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, 220);
    
}

#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    
    mCell.choiceBtn.hidden = YES;
       return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SGoodsInfor * info = [[SGoodsInfor alloc] init];
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
@end
