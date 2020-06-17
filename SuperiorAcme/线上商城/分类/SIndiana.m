//
//  SIndiana.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndiana.h"
#import "SNBannerView.h"
#import "SIndianaView.h"
#import "SOnlineShopCell.h"
#import "SIndianaInfor.h"

#import "SOneBuyOneBuyIndex.h"
#import "GYChangeTextView.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"

@interface SIndiana () <SNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GYChangeTextViewDelegate>
{
    SIndianaView * indianType;
    NSMutableArray * arr;//列表
    NSInteger  page;
    
    NSString * is_hot;//当is_hot 为1的时候 显示热门
    NSString * integral;//排序参数 按照积分排序 1正序 2倒序
    NSString * add_num;//排序参数 按照已经参与人数（进度）排序 1正序 2倒序
    NSString * person_num;//排序参数 按照需参与人数排序 1正序 2倒序
    
    GYChangeTextView * tView;
    
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@end

@implementation SIndiana

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    is_hot = @"1";
    integral = @"";
    add_num = @"";
    person_num = @"";
    page = 1;
    [self initRefresh];
    [self showModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"积分抽奖";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)initRefresh
{
    __block SIndiana * blockSelf = self;
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
    SOneBuyOneBuyIndex * list = [[SOneBuyOneBuyIndex alloc] init];
    list.is_hot = is_hot;
    list.integral = integral;
    list.add_num = add_num;
    list.person_num = person_num;
    list.p = [@(page) stringValue];
    [MBProgressHUD showMessage:nil toView:self.view];
    [list sOneBuyOneBuyIndexSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SOneBuyOneBuyIndex * list = (SOneBuyOneBuyIndex *)data;
        
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/1242*400) delegate:self model:list.data.ads URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [_mCollect addSubview:banner];
        
        SOneBuyOneBuyIndex * list_banner = list.data.ads.firstObject;
        url_merchant_id = list_banner.merchant_id;
        url_goods_id = list_banner.goods_id;
        url_href = list_banner.href;
        
        
        [tView removeFromSuperview];
        tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 40 - 30, 40)];
        tView.delegate = self;
        [indianType.autoView addSubview:tView];
        NSMutableArray * arr_title = [[NSMutableArray alloc] init];
        for (SOneBuyOneBuyIndex * listTitle in list.data.news) {
            [arr_title addObject:listTitle.title];
        }
        if (arr_title.count != 0) {
            [tView animationWithTexts:arr_title];
        }
        
        if (page == 1) {
            arr = [NSMutableArray arrayWithArray:list.data.oneBuyList];
            [_mCollect.mj_footer resetNoMoreData];
        } else {
            if (list.data.oneBuyList.count) {
                
                [arr addObjectsFromArray:list.data.oneBuyList];
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
    
    
    
    indianType = [[SIndianaView alloc] initWithFrame:CGRectMake(0, ScreenW/1242*400, ScreenW, 85)];
    [_mCollect addSubview:indianType];
    [indianType.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [indianType.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [indianType.threeBtn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [indianType.fourBtn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [indianType.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [indianType.twoBtn setTag:0];
    [indianType.threeBtn setTag:0];
    [indianType.fourBtn setTag:0];
    
    
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollect.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    
}
#pragma mark - 热门
- (void)oneBtnClick {
    [indianType.oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [indianType.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.twoBtn setTag:0];
    [indianType.threeBtn setTag:0];
    [indianType.fourBtn setTag:0];
    [indianType.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [indianType.threeBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [indianType.fourBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    is_hot = @"1";
    integral = @"";
    add_num = @"";
    person_num = @"";
    page = 1;
    [self showModel];
}
#pragma mark - 积分
- (void)twoBtnClick:(UIButton *)btn {
    [indianType.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [indianType.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.threeBtn setTag:0];
    [indianType.fourBtn setTag:0];
    [indianType.threeBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [indianType.fourBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    if (btn.tag == 0) {
        [indianType.twoBtn setTag:1];
        [indianType.twoBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];

        is_hot = @"";
        integral = @"2";
        add_num = @"";
        person_num = @"";
        page = 1;
        [self showModel];
    } else {
        [indianType.twoBtn setTag:0];
        [indianType.twoBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        is_hot = @"";
        integral = @"1";
        add_num = @"";
        person_num = @"";
        page = 1;
        [self showModel];
    }
}
#pragma mark - 进度
- (void)threeBtnClick:(UIButton *)btn {
    [indianType.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [indianType.fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.twoBtn setTag:0];
    [indianType.fourBtn setTag:0];
    [indianType.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [indianType.fourBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    if (btn.tag == 0) {
        [indianType.threeBtn setTag:1];
        [indianType.threeBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];
        is_hot = @"";
        integral = @"";
        add_num = @"2";
        person_num = @"";
        page = 1;
        [self showModel];
    } else {
        [indianType.threeBtn setTag:0];
        [indianType.threeBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        [indianType.twoBtn setTag:0];
        [indianType.twoBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        is_hot = @"";
        integral = @"";
        add_num = @"1";
        person_num = @"";
        page = 1;
        [self showModel];
    }
}
#pragma mark - 人次
- (void)fourBtnClick:(UIButton *)btn {
    [indianType.oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [indianType.fourBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [indianType.twoBtn setTag:0];
    [indianType.threeBtn setTag:0];
    [indianType.twoBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];
    [indianType.threeBtn setImage:[UIImage imageNamed:@"升降默认"] forState:UIControlStateNormal];

    if (btn.tag == 0) {
        [indianType.fourBtn setTag:1];
        [indianType.fourBtn setImage:[UIImage imageNamed:@"升降降"] forState:UIControlStateNormal];
        is_hot = @"";
        integral = @"";
        add_num = @"";
        person_num = @"2";
        page = 1;
        [self showModel];
    } else {
        [indianType.fourBtn setTag:0];
        [indianType.fourBtn setImage:[UIImage imageNamed:@"升降升"] forState:UIControlStateNormal];
        is_hot = @"";
        integral = @"";
        add_num = @"";
        person_num = @"1";
        page = 1;
        [self showModel];
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(ScreenW/1242*400 + 80 + 10, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40 + 40);
    
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
    mCell.integral_num.hidden = YES;//已售xx件
    
    mCell.goods_PriceView.hidden = YES;
    mCell.goods_priceHHH.constant = 0;//30
    
    mCell.carView.hidden = YES;
    mCell.carView_HHH.constant = 0;//70
    
    mCell.houseView.hidden = YES;
    mCell.houseView_HHH.constant = 0;//90
    
    mCell.redView.hidden = NO;
    mCell.redView_HHH.constant = 30;//30
    
    mCell.timeView.hidden = NO;
    mCell.timeView_HHH.constant = 30;//30
    mCell.time_submit.hidden = YES;
    mCell.blueView.hidden = YES;
    mCell.blueView_HHH.constant = 0;//30
    
    SOneBuyOneBuyIndex * list = arr[indexPath.row];

    
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
    mCell.model = arr[indexPath.row];

    
    return mCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SOneBuyOneBuyIndex * list = arr[indexPath.row];

    SIndianaInfor * infor = [[SIndianaInfor alloc] init];
    infor.one_buy_id = list.one_buy_id;
    [self.navigationController pushViewController:infor animated:YES];
}
@end
