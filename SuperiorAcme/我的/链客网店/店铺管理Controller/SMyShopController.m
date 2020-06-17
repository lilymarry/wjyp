//
//  SMyShopController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMyShopController.h"
#import "SMyShopHeaderView.h"
#import "SMyShopCell.h"
#import "SMyShopCollectionHeaderReusableView.h"
#import "SShopManagementModel.h"


#import "SShopPickUpGoodsController.h"
#import "SGoodManagementController.h"
#import "SShopSettingController.h"
#import "SCustomerManagementController.h"
#import "SOrderManagementController.h"
#import "StoreStatisticsVC.h"
#import "ApplyYellowController.h"

#import "SharePopViewController.h"
#import "AShare.h"
@interface SMyShopController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,refrechUserSetViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mCollection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *mCollectionFlowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewToTopCons;
@property (weak, nonatomic) IBOutlet UIView *HeaderContainView;

@property (nonatomic, strong) SMyShopHeaderView * myShopHeaderView;

@property (nonatomic, strong) NSArray * dataArr;
@property (nonatomic, strong) SShopManagementModel * shopManagementModel;

@property (nonatomic, copy) NSString * shopName;
@property (nonatomic, copy) NSString * shopDesc;
@property (nonatomic, copy) NSString * shopPicUrl;
@property (nonatomic, copy) NSString * shopEndTime;
@end

static NSString * SMyShopCellID = @"SMyShopCellID";
static NSString * CollectionHeaderViewID = @"CollectionHeaderViewID";

@implementation SMyShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"链客网店";
    
    [self.HeaderContainView addSubview:self.myShopHeaderView];

    [_mCollection registerNib:[UINib nibWithNibName:NSStringFromClass([SMyShopCell class]) bundle:nil] forCellWithReuseIdentifier:SMyShopCellID];
    [_mCollection registerNib:[UINib nibWithNibName:NSStringFromClass([SMyShopCollectionHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderViewID];

    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if ([_hasShop isEqualToString:@"2"]) {
        [MBProgressHUD showSuccess:@"您的店铺已过期，请重新申请" toView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    }
     [self GetShopMessage];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置系统状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
   
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.myShopHeaderView.frame = self.HeaderContainView.bounds;
}

#pragma mark - =========================== UICollectionViewDataSource =============================
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SMyShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SMyShopCellID forIndexPath:indexPath];
    
    NSDictionary * dict = self.dataArr[indexPath.row];
    cell.titleLabel.text = dict[@"title"];
    cell.iconImageView.image = [UIImage imageNamed:dict[@"icon"]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // 如果是头视图
    if (kind == UICollectionElementKindSectionHeader) {
        // 从重用池里面取
        SMyShopCollectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderViewID forIndexPath:indexPath];
        
        return headerView;
        
    }else{
        return nil;
    }
}

#pragma mark - =========================== UICollectionViewDelegate =============================
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        //小店上货
        SShopPickUpGoodsController * pickUpGoodVC = [[SShopPickUpGoodsController alloc] init];
        pickUpGoodVC.shopId=_shopid;
        pickUpGoodVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pickUpGoodVC animated:YES];
    }else if (indexPath.item == 1){
        //商品管理
        SGoodManagementController * goodManagmentVC = [[SGoodManagementController alloc] init];
        goodManagmentVC.shopid=_shopid;
        goodManagmentVC.shopidMing=_shopidMing;
        goodManagmentVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goodManagmentVC animated:YES];
    }else if (indexPath.item == 2){
        //小店营收
        StoreStatisticsVC *ssvc = [[StoreStatisticsVC alloc] init];
        ssvc.shopId=_shopid;
        [self.navigationController pushViewController:ssvc animated:YES];
    }else if (indexPath.item == 3) {
        //订单管理
        SOrderManagementController * orderManagementVC = [[SOrderManagementController alloc] init];
        orderManagementVC.shopId=_shopid;
        [self.navigationController pushViewController:orderManagementVC animated:YES];
    }else if (indexPath.item == 4){
        //顾客管理
        SCustomerManagementController * customerManagementVC = [[SCustomerManagementController alloc] init];
        customerManagementVC.shopId=_shopid;
        [self.navigationController pushViewController:customerManagementVC animated:YES];
    }else if (indexPath.item == 5){
        //店铺设置
        SShopSettingController * shopSettingVC = [[SShopSettingController alloc] init];
        shopSettingVC.delgate=self;
        shopSettingVC.shopId=_shopid;
        shopSettingVC.shopName = self.shopName;
        shopSettingVC.shopDesc = self.shopDesc;
        shopSettingVC.shopPicUrl = self.shopPicUrl;
        shopSettingVC.shopTime=self.shopEndTime;
        [self.navigationController pushViewController:shopSettingVC animated:YES];
    }
    else if (indexPath.item == 6){
        //黄劵审核
        ApplyYellowController * shopSettingVC = [[ApplyYellowController alloc] init];
        shopSettingVC.shopId=_shopid;
        [self.navigationController pushViewController:shopSettingVC animated:YES];
    }
    else if (indexPath.item == 7){
        AShare * shareVC = [[AShare alloc] init];
        shareVC.thisImage=self.shopPicUrl;
        shareVC.thisTitle = self.shopName;
        if (self.shopDesc.length==0) {
            shareVC.thisContent =@"终于等到你，还好我没放弃。欢迎光临本店~";
        }
        else
        {
           shareVC.thisContent =self.shopDesc;
        }
        shareVC.thisType=@"2";
        shareVC.id_val=_shopid;
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Distribution/DistributionShop/shop", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        NSString *urlStr=[NSString stringWithFormat:@"%@/shop_id/%@.html",detail_Base_url,_shopidMing];
        
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length!=0) {
            urlStr =[NSString stringWithFormat:@"%@/shop_id/%@/invite_code/%@.html",detail_Base_url,_shopidMing,invite_code];
        }
        shareVC.thisUrl = urlStr;
        
        shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:shareVC animated:YES completion:nil];
        shareVC.AShare_back = ^{
            
        };
        
        /*
        SharePopViewController * shareViewVC = [[SharePopViewController alloc] init];
        shareViewVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        shareViewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        shareViewVC.goodsName=self.shopName;
        shareViewVC.share_img=self.shopPicUrl;
        if (self.shopDesc.length==0) {
              shareViewVC.share_content=@"终于等到你，还好我没放弃。欢迎光临本店~";
        }
        else
        {
           shareViewVC.share_content=self.shopDesc;
        }
      
        shareViewVC.shopidMing=_shopidMing;
        shareViewVC.fag=@"3";
        shareViewVC.share_type=@"2";
        shareViewVC.goods_id=_shopid;

        [self presentViewController:shareViewVC animated:YES completion:nil];
         */
    }
}
#pragma mark - =========================== UICollectionViewDelegateFlowLayout =============================
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat ItemW = (ScreenW -_mCollectionFlowLayout.minimumInteritemSpacing * 2) / 3;
    CGFloat ItemH = ItemW * 0.8;
    return CGSizeMake(ItemW, ItemH);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(414, 46);
}

//获取店铺信息
-(void)GetShopMessage{
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    [SShopManagementModel getShopMessageWithShopID:_shopid andSuccess:^(NSString *code, NSString *message, id data, NSString *nums) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
      //  [MBProgressHUD showSuccess:message toView:self.view];
        if ([data isKindOfClass:[NSArray class]]) {
            NSArray * dataArr = (NSArray *)data;
            if (dataArr.count > 0) {
                self.shopManagementModel = dataArr.firstObject;
            }
        }else{
            self.shopManagementModel = (SShopManagementModel *)data;
        }
        
        self.shopName = self.shopManagementModel.shop_name;
        self.shopDesc = self.shopManagementModel.shop_desc;
        self.shopPicUrl = self.shopManagementModel.shop_url;
        self.shopEndTime= self.shopManagementModel.end_time;
       // NSLog(@"AAAA %@",self.shopDesc);
        self.myShopHeaderView.shopManagementModel = self.shopManagementModel;
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [MBProgressHUD showSuccess:[error localizedDescription] toView:self.view];
    }];
}
-(void)refrechUserSetView
{
    [self GetShopMessage];
}
#pragma mark - 重写Getter方法
-(SMyShopHeaderView *)myShopHeaderView{
    if (!_myShopHeaderView) {
        _myShopHeaderView = [SMyShopHeaderView CreatMyShopHeaderView];
    }
    return _myShopHeaderView;
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[
                     @{
                         @"title":@"小店上货",
                         @"icon":@"小店上货"
                         },
                     @{
                         @"title":@"商品管理",
                         @"icon":@"商品管理"
                         },
                     @{
                         @"title":@"小店营收",
                         @"icon":@"小店营收"
                         },
                     @{
                         @"title":@"订单管理",
                         @"icon":@"订单管理"
                         },

                     @{
                         @"title":@"顾客管理",
                         @"icon":@"顾客管理"
                         },
                     @{
                         @"title":@"店铺设置",
                         @"icon":@"店铺设置"
                         },
                     @{
                         @"title":@"黄券审核",
                         @"icon":@"黄劵审核"
                         },
                   
                     @{
                         @"title":@"分享店铺",
                         @"icon":@"分享店铺"
                         }
                     ];
    }
    return _dataArr;
}
@end
