//
//  SHouseInfor_subInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInfor_subInfor.h"
#import "SNBannerView.h"
#import "SHouseInfor_subInfor_top.h"
#import "XRWaterfallLayout.h"
#import "SOnlineShopCell_house.h"
#import "SGoodsInfor.h"
#import "SHouseBuyStyleInfo.h"
#import "CQPlaceholderView.h"
#import "SHouseConfirm.h"
#import "SUserUserCenter.h"
#import "SShopCar.h"

@interface SHouseInfor_subInfor () <SNBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate,CQPlaceholderViewDelegate>
{
    SHouseInfor_subInfor_top * top;
    NSArray * arr;
    CQPlaceholderView * placeholderView;
    
    NSString * model_house_id;
    NSString * model_house_img;
    NSString * model_house_name;
    NSString * model_pre_money;
    NSString * model_all_price;
    NSString * model_true_pre_money;
    NSString * model_developer;
    NSString * model_one_price;
    
    NSString * easemob_account;//:'客服环信账号'
    NSString * server_head_pic;//:客服头像
    NSString * server_name;//：客服名称
    
    NSString * merchant_id;//商家id
}

@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UILabel *car_num;
@property (weak, nonatomic) IBOutlet UIButton *moveTopBtn;
@end

@implementation SHouseInfor_subInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    [self createUI];
    
    _moveTopBtn.hidden = YES;
    _car_num.layer.masksToBounds = YES;
    _car_num.layer.cornerRadius = _car_num.frame.size.height/2;
    
    [self showModel];
}
- (void)showModel {
    SHouseBuyStyleInfo * infor = [[SHouseBuyStyleInfo alloc] init];
    infor.style_id = _style_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sHouseBuyStyleInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SHouseBuyStyleInfo * infor = (SHouseBuyStyleInfo *)data;
            
            model_house_id = infor.data.id;
            model_house_img = infor.data.house_style_img;
            model_house_name = infor.data.style_name;
            model_pre_money = infor.data.pre_money;
            model_all_price = infor.data.all_price;
            model_true_pre_money = infor.data.true_pre_money;
            model_developer = infor.data.developer;
            model_one_price = infor.data.one_price;
            
//            self.title = infor.data.house_style_desc;
            
            top.style_name.text = infor.data.style_name;
            top.style_name_sub.text = infor.data.tags;
            top.pre_money.text = infor.data.pre_money;
            top.one_price.text = [NSString stringWithFormat:@"%@元/平",infor.data.one_price];
            top.integral.text = infor.data.integral;
            top.true_pre_money.text = [NSString stringWithFormat:@"可抵￥%@房款",infor.data.true_pre_money];
            top.all_price.text = [NSString stringWithFormat:@"房全价￥%@",infor.data.all_price];
            top.area.text = [NSString stringWithFormat:@"%@m²",infor.data.area];
            top.thisAddress.text = infor.data.house_address;

            SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW) delegate:self model:infor.data.banner URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            [top.bannerView addSubview:banner];
            
            arr = infor.data.other_style;
            [_mCollect reloadData];
            
            if ([infor.data.cart_num integerValue] < 1) {
                _car_num.hidden = YES;
            } else {
                _car_num.hidden = NO;
                _car_num.text = infor.data.cart_num;
            }
            easemob_account = infor.data.easemob_account;
            server_head_pic = infor.data.server_head_pic;
            server_name = infor.data.server_name;
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    [self showModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollect, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.title = @"户型";

    
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
    
    top = [[SHouseInfor_subInfor_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW + 220 + 50)];
    [_mCollect addSubview:top];
    
    
    
    XRWaterfallLayout * waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    [waterfall setColumnSpacing:5 rowSpacing:5 sectionInset:UIEdgeInsetsMake(ScreenW + 220 + 50, 0, 5, 0)];
    waterfall.delegate = self;
    _mCollect.collectionViewLayout = waterfall;
    
    //隐藏滚轴
    _mCollect.showsHorizontalScrollIndicator = NO;
    //Cell
    [_mCollect registerNib:[UINib nibWithNibName:@"SOnlineShopCell_house" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell_house"];
    
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mCollect.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mCollect addSubview:placeholderView];
    placeholderView.hidden = YES;
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
    return ScreenW/2 - 2.5 + 40 + 70 + 30 + 40 + 15 + 20;
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SOnlineShopCell_house *mCell = [_mCollect dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell_house" forIndexPath:indexPath];
    
    SHouseBuyStyleInfo * list = arr[indexPath.row];
    [mCell.house_style_img sd_setImageWithURL:[NSURL URLWithString:list.house_style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    mCell.style_name.text = list.style_name;
    mCell.pre_money.text = [NSString stringWithFormat:@"￥%@",list.pre_money];
    mCell.one_price.text = [NSString stringWithFormat:@"%@元/平",list.one_price];
    mCell.true_pre_money.text = [NSString stringWithFormat:@"可抵￥%@房款",list.true_pre_money];
    mCell.integral.text = list.integral;
    mCell.all_price.text = [NSString stringWithFormat:@"房全价￥%@",list.all_price];
    mCell.developer.text = list.developer;
    [mCell.red_pro setProgress:[list.sell_num floatValue]/[list.total floatValue]];
    if ([list.ticket_discount integerValue] == 0) {
        mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
        mCell.top_oneTitle.text = @"不可使用代金券";
    } else {
        mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
        mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_discount];
    }
    if ([list.country_id isEqualToString:@"0"]) {
        mCell.country_logo.hidden = YES;
    } else {
        mCell.country_logo.hidden = NO;
    }
    [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SHouseBuyStyleInfo * list = arr[indexPath.row];

    SHouseInfor_subInfor * subInfor = [[SHouseInfor_subInfor alloc] init];
    subInfor.style_id = list.style_id;
    [self.navigationController pushViewController:subInfor animated:YES];
}
- (IBAction)submitBtn:(UIButton *)sender {
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
    SHouseConfirm * confirm = [[SHouseConfirm alloc] init];
    confirm.model_house_id = model_house_id;
    confirm.model_house_img = model_house_img;
    confirm.model_house_name = model_house_name;
    confirm.model_pre_money = model_pre_money;
    confirm.model_all_price = model_all_price;
    confirm.model_true_pre_money = model_true_pre_money;
    confirm.model_developer = model_developer;
    confirm.model_one_price = model_one_price;
    [self.navigationController pushViewController:confirm animated:YES];
}
- (IBAction)moveTopBtn:(UIButton *)sender {
    [_mCollect setContentOffset:CGPointMake(0, 0) animated:YES];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenW) {
        _moveTopBtn.hidden = NO;
    } else {
        _moveTopBtn.hidden = YES;
    }
}
#pragma mark - 回首页
- (IBAction)backHome:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 购物车
- (IBAction)carBtn:(UIButton *)sender {
    SShopCar * car = [[SShopCar alloc] init];
    car.type = YES;
    car.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:car animated:YES];
}
#pragma mark - 客服
- (IBAction)messageBtn:(UIButton *)sender {
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
    SHyphenateList * list = [[SHyphenateList alloc] init];
    if (merchant_id == nil) {
        [MBProgressHUD showError:@"商家id错误" toView:self.view];
        return;
    }
    list.merchant_id = merchant_id;
    list.modalPresentationStyle = UIModalPresentationOverFullScreen;
    list.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:list animated:YES completion:nil];
    list.SHyphenateList_choice = ^(NSString *header_pic, NSString *nickname, NSString *hx) {
        SUserUserCenter * center = [[SUserUserCenter alloc] init];
        [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SUserUserCenter * center = (SUserUserCenter *)data;
                
                //环信ID:@"8001"
                //聊天类型:EMConversationTypeChat
                EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:hx conversationType:EMConversationTypeChat];
                chatController.title = nickname;
                chatController.nickname_mine = center.data.nickname;
                chatController.pic_mine = center.data.head_pic;
                chatController.nickname_other = nickname;
                chatController.pic_other = header_pic;
                [self.navigationController pushViewController:chatController animated:YES];
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    };
}
@end
