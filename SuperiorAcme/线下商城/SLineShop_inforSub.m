//
//  SLineShop_inforSub.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_inforSub.h"
#import "AShare.h"
#import "SBusinessQualification.h"
#import "SReportingMerchant.h"
#import "SEva.h"

#import "SMerchantMerInfo.h"
#import "SUserCollectAddCollect.h"
#import "SUserCollectDelOneCollect.h"

@interface SLineShop_inforSub ()
{
    UIButton * rightBtn_sub;
    BOOL collect_isno;//NO未收藏 YES已收藏
    
    NSString * share_url;//分享链接
    NSString * share_img;//"分享图片",
    NSString * share_content;//"分享内容"
    NSString * goods_id;//
}
@property (strong, nonatomic) IBOutlet UIScrollView *mScroll;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIButton *evaBtn;//产看用户的全部评价
@property (strong, nonatomic) IBOutlet UIButton *qualificationsBtn;//查看商家资质
@property (strong, nonatomic) IBOutlet UIButton *reportBtn;//举报商家抢红包
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;

@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *total;
@property (strong, nonatomic) IBOutlet UIImageView *head_pic;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *create_time;

@property (strong, nonatomic) IBOutlet UILabel *goods_total;
@property (strong, nonatomic) IBOutlet UILabel *goods_month_num;
@property (strong, nonatomic) IBOutlet UILabel *view_num;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *open_time;

@end

@implementation SLineShop_inforSub

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
    _oneView.layer.masksToBounds = YES;
    _oneView.layer.cornerRadius = 3;
    _twoView.layer.masksToBounds = YES;
    _twoView.layer.cornerRadius = 3;
    _head_pic.layer.masksToBounds = YES;
    _head_pic.layer.cornerRadius = _head_pic.frame.size.width/2;
    
    
    
    [_evaBtn addTarget:self action:@selector(evaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_qualificationsBtn addTarget:self action:@selector(qualificationsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_reportBtn addTarget:self action:@selector(reportBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self showModel];
}
- (void)showModel {
    if (_type == YES) {
        _mScroll.backgroundColor = MyBlue;
        SMerchantMerInfo * infor = [[SMerchantMerInfo alloc] init];
        infor.merchant_id = _merchant_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sMerchantMerInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SMerchantMerInfo * infor = (SMerchantMerInfo *)data;
                
                share_url = infor.data.share_url;
                share_img = infor.data.share_img;
                share_content = infor.data.share_content;
                
                if ([infor.data.is_collect isEqualToString:@"0"]) {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                    
                    collect_isno = NO;
                } else {
                    [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                    [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                    
                    collect_isno = YES;
                }
                
                goods_id = infor.data.mer_comment.one_comment.goods_id;
                _score.text = infor.data.mer_comment.score;
                _total.text = infor.data.mer_comment.total;
                [_head_pic sd_setImageWithURL:[NSURL URLWithString:infor.data.mer_comment.one_comment.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                _nickname.text = infor.data.mer_comment.one_comment.nickname;
                _create_time.text = infor.data.mer_comment.one_comment.create_time;
                for (UIView * view in _starView.subviews) {
                    [view removeFromSuperview];
                }
                for (int i = 0; i < [infor.data.mer_comment.one_comment.all_star integerValue]; i++) {
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 20, 0, 15, 15)];
                    [_starView addSubview:imageView];
                    
                    imageView.image = [UIImage imageNamed:@"星星黄"];
                }
                
                _goods_total.text = [NSString stringWithFormat:@"商品数量：%@",infor.data.mer_info.goods_total];
                _goods_month_num.text = [NSString stringWithFormat:@"月销单：%@",infor.data.mer_info.goods_month_num];
                _view_num.text = [NSString stringWithFormat:@"关注人数：%@",infor.data.mer_info.view_num];
                _address.text = [NSString stringWithFormat:@"门店地址：%@",infor.data.mer_info.address];
                _phone.text = [NSString stringWithFormat:@"门店电话：%@",infor.data.mer_info.phone];
                _open_time.text = [NSString stringWithFormat:@"营业时间：%@",infor.data.mer_info.open_time];
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mScroll, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = _merchant_name;
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
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-3, 13, 10, 0);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake( 0,-15,-23, 0);
    
    [rightBtn setImage:[UIImage imageNamed:@"详情分享"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 50, 50);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(-3, 20, 10, 0);
    rightBtn_sub.titleEdgeInsets = UIEdgeInsetsMake( 0,-10,-21, 0);
    
    rightBtn_sub.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn_sub setTitleColor:WordColor forState:UIControlStateNormal];
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
        
    self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 分享
- (void)rightBtnClick {
//    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [self.view addSubview:view];
    
    AShare * shareVC = [[AShare alloc] init];
//    shareVC.thisUrl = share_url;
    //SharedWapStoreInfoUrl
    shareVC.thisUrl = SharedWapStoreInfoUrl(_merchant_id);
    shareVC.thisImage = share_img;
    shareVC.thisTitle = _merchant_name;
    shareVC.thisContent = share_content;
    shareVC.thisType = @"2";
    shareVC.id_val = _merchant_id;
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
//        [backGroundView removeFromSuperview];
//        [view removeFromSuperview];
    };
}
#pragma mark - 收藏
- (void)rightBtn_subClick {
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
    if (collect_isno == NO) {
        SUserCollectAddCollect * collect = [[SUserCollectAddCollect alloc] init];
        collect.type = @"2";
        collect.id_val = _merchant_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [collect sUserCollectAddCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏选中"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"已收藏" forState:UIControlStateNormal];
                
                collect_isno = YES;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else {
        SUserCollectDelOneCollect * delCollect = [[SUserCollectDelOneCollect alloc] init];
        delCollect.type = @"2";
        delCollect.id_val = _merchant_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [delCollect sUserCollectDelOneCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [rightBtn_sub setImage:[UIImage imageNamed:@"详情收藏默认"] forState:UIControlStateNormal];
                [rightBtn_sub setTitle:@"收藏" forState:UIControlStateNormal];
                
                collect_isno = NO;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
#pragma mark - 商家评价
- (void)evaBtnClick {
    SEva * eva = [[SEva alloc] init];
    eva.hidesBottomBarWhenPushed = YES;
    eva.type = YES;
    eva.merchant_id = _merchant_id;
    eva.goods_id = @"";
    [self.navigationController pushViewController:eva animated:YES];
}
#pragma mark - 商家资质
- (void)qualificationsBtnClick {
    SBusinessQualification * bq = [[SBusinessQualification alloc] init];
    bq.merchant_id = _merchant_id;
    [self.navigationController pushViewController:bq animated:YES];
}
#pragma mark - 举报商家
- (void)reportBtnClick {
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
    SReportingMerchant * rm = [[SReportingMerchant alloc] init];
    rm.merchant_id = _merchant_id;
    [self.navigationController pushViewController:rm animated:YES];
}
@end
