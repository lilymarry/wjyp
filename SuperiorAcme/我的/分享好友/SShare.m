//
//  SShare.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShare.h"
#import "AShare.h"
#import "SUserShareFriend.h"
#import "SOnlineShopInfor.h"
#import "SMessageInfor.h"

@interface SShare () <UITextViewDelegate>
{
    NSString * share_id;//"分享id",
    NSString * share_img;//"分享图片",
    NSString * share_title;//"分享标题",
    NSString * share_url;//"分享链接"
    
    NSString * url_merchant_id;//”：“店铺id”
    NSString * url_goods_id;//”：“商品id”
    NSString * url_href;//": "广告链接"
}
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *shareTitle;
@property (strong, nonatomic) IBOutlet UITextView *shareContentTV;
@end

@implementation SShare

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _shareContentTV.delegate = self;
    
    SUserShareFriend * infor = [[SUserShareFriend alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sUserShareFriendSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserShareFriend * infor = (SUserShareFriend *)data;
            share_id = infor.data.share_id;
            share_img = infor.data.share_img;
            [_headerImage sd_setImageWithURL:[NSURL URLWithString:infor.data.share_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            share_title = infor.data.share_title;
            _shareTitle.text = infor.data.share_title;
            share_url = infor.data.share_url;
            url_merchant_id = infor.data.merchant_id;
            url_goods_id = infor.data.goods_id;
            url_href = infor.data.href;
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"分享好友";
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入文字"]) {
        textView.text = @"";
        _shareContentTV.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入文字";
        _shareContentTV.textColor = WordColor_30;
    }
    return YES;
}
- (void)submitBtnClick {
    if ([_shareContentTV.text isEqualToString:@"请输入文字"]) {
        [MBProgressHUD showError:@"请输入文字" toView:self.view];
        return;
    }
//    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
//    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [self.view addSubview:view];
    
    AShare * shareVC = [[AShare alloc] init];
    shareVC.thisUrl = share_url;
    shareVC.thisImage = share_img;
    shareVC.thisTitle = share_title;
    shareVC.thisContent = _shareContentTV.text;
    shareVC.thisType = @"5";
    shareVC.id_val = share_id;
    shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:shareVC animated:YES completion:nil];
    shareVC.AShare_back = ^{
//        [backGroundView removeFromSuperview];
//        [view removeFromSuperview];
    };
}
- (IBAction)imageBtn:(UIButton *)sender {
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
@end
