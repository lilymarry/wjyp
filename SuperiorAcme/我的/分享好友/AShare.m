//
//  AShare.m
//  AntLeader
//
//  Created by TXD_air on 2017/3/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "AShare.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "SUserShareBack.h"

@interface AShare ()
{
   UIImage * nowImage;
}
@property (strong, nonatomic) IBOutlet UIButton *backbtn_1;
@property (strong, nonatomic) IBOutlet UIButton *backBtn_2;

@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;

@property (strong, nonatomic) IBOutlet UIImageView *shareImage;
@property (strong, nonatomic) IBOutlet UIButton *shareUrlBtn;
@end

@implementation AShare

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_backbtn_1 addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn_2 addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_fiveBtn addTarget:self action:@selector(fiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:_thisUrl] withSize:250.0f];
//    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
//    _shareImage.image = customQrcode;
    [_shareUrlBtn setTitle:_thisUrl forState:UIControlStateNormal];
    [_shareUrlBtn addTarget:self action:@selector(shareUrlBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _shareUrlBtn.hidden = YES;
    
  // nowImage = [self getImageFromURL:_thisImage];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        [MBProgressHUD showError:@"您未登陆，这会导致无法获得分享收益!" toView:self.view];
    }
}
- (void)shareUrlBtnClick {
    UIPasteboard *appPasteBoard =  [UIPasteboard generalPasteboard];
    appPasteBoard.persistent = YES;
    NSString *pasteStr = _thisUrl;
    [appPasteBoard setString:pasteStr];
    
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"完成复制",nil),nil] message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//    [alertview show];
}
- (void)backClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    if (self.AShare_back) {
//        self.AShare_back();
//    }
    
}

//#pragma mark - 微信朋友圈
- (void)oneBtnClick {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupWeChatParamsByText:_thisContent title:_thisTitle url:[NSURL URLWithString:_thisUrl] thumbImage:_thisImage image:_thisImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         //         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:
                 
                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                     SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                     shareBack.type = @"1";
                     shareBack.content = _thisContent;
                     shareBack.id_val = _id_val;
                     shareBack.share_type = _thisType;
                     shareBack.url = _thisUrl;
                     [MBProgressHUD showMessage:nil toView:self.view];
                     [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if ([code isEqualToString:@"1"]) {
                             [MBProgressHUD showSuccess:message toView:self.view];
                         } else {
                             //  [MBProgressHUD showError:message toView:self.view];
                         }
                         if (self.AShare_back) {
                             self.AShare_back();
                         }
                     } andFailure:^(NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                     }];
                 }
                 
                 
                 break;
             case SSDKResponseStateFail:
                 //                 [MBProgressHUD showError:@"分享失败" toView:self.view];
                 break;
             case SSDKResponseStateCancel:
                 //                 [MBProgressHUD showError:@"分享取消" toView:self.view];
                 break;
             default:
                 break;
         }
     }];
}
#pragma mark - 微信好友
- (void)twoBtnClick {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupWeChatParamsByText:_thisContent title:_thisTitle url:[NSURL URLWithString:_thisUrl] thumbImage:_thisImage image:_thisImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
    [ShareSDK share:SSDKPlatformSubTypeWechatSession
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:

                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                     SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                     shareBack.type = @"1";
                     shareBack.content = _thisContent;
                     shareBack.id_val = _id_val;
                     shareBack.share_type = _thisType;
                     shareBack.url = _thisUrl;
                     [MBProgressHUD showMessage:nil toView:self.view];
                     [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if ([code isEqualToString:@"1"]) {
                             [MBProgressHUD showSuccess:message toView:self.view];
                         } else {
                             //  [MBProgressHUD showError:message toView:self.view];
                         }
                         if (self.AShare_back) {
                             self.AShare_back();
                         }
                     } andFailure:^(NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                     }];
                 }
                 
                 
                 break;
             case SSDKResponseStateFail:
                 //                 [MBProgressHUD showError:@"分享失败" toView:self.view];
                 break;
             case SSDKResponseStateCancel:
                 //                 [MBProgressHUD showError:@"分享取消" toView:self.view];
                 break;
             default:
                 break;
         }
     }];
}
#pragma mark - QQ好友
- (void)threeBtnClick {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupQQParamsByText:_thisContent title:_thisTitle url:[NSURL URLWithString:_thisUrl] thumbImage:_thisImage image:_thisImage type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
    [ShareSDK share:SSDKPlatformSubTypeQQFriend
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:

                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                     SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                     shareBack.type = @"3";
                     shareBack.content = _thisContent;
                     shareBack.id_val = _id_val;
                     shareBack.share_type = _thisType;
                     shareBack.url = _thisUrl;
                     [MBProgressHUD showMessage:nil toView:self.view];
                     [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if ([code isEqualToString:@"1"]) {
                             [MBProgressHUD showSuccess:message toView:self.view];
                         } else {
                             //  [MBProgressHUD showError:message toView:self.view];
                         }
                         if (self.AShare_back) {
                             self.AShare_back();
                         }
                     } andFailure:^(NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                     }];
                 }
                 
                 break;
             case SSDKResponseStateFail:
                 //                 [MBProgressHUD showError:@"分享失败" toView:self.view];
                 break;
             case SSDKResponseStateCancel:
                 //                 [MBProgressHUD showError:@"分享取消" toView:self.view];
                 break;
             default:
                 break;
         }
     }];
}
#pragma mark - 新浪微博
- (void)fourBtnClick {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@%@",_thisContent == nil ? @"" : _thisContent,_thisUrl] title:_thisTitle image:_thisImage url:[NSURL URLWithString:_thisUrl] latitude:0 longitude:0 objectID:@"" type:SSDKContentTypeImage];
    
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:

                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                     SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                     shareBack.type = @"2";
                     shareBack.content = _thisContent;
                     shareBack.id_val = _id_val;
                     shareBack.share_type = _thisType;
                     shareBack.url = _thisUrl;
                     [MBProgressHUD showMessage:nil toView:self.view];
                     [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if ([code isEqualToString:@"1"]) {
                             [MBProgressHUD showSuccess:message toView:self.view];
                         } else {
                           //  [MBProgressHUD showError:message toView:self.view];
                         }
                         if (self.AShare_back) {
                             self.AShare_back();
                         }
                     } andFailure:^(NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                     }];
                 }
                 
                 break;
             case SSDKResponseStateFail:
                 //                 [MBProgressHUD showError:@"分享失败" toView:self.view];
                 break;
             case SSDKResponseStateCancel:
                 //                 [MBProgressHUD showError:@"分享取消" toView:self.view];
                 break;
             default:
                 break;
         }
     }];
}
//#pragma mark - qq空间
- (void)fiveBtnClick {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupQQParamsByText:_thisContent title:_thisTitle url:[NSURL URLWithString:_thisUrl] thumbImage:_thisImage image:_thisImage type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeQZone];

    [ShareSDK share:SSDKPlatformSubTypeQZone
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         //         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:
                 
                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                     SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                     shareBack.type = @"3";
                     shareBack.content = _thisContent;
                     shareBack.id_val = _id_val;
                     shareBack.share_type = _thisType;
                     shareBack.url = _thisUrl;
                     [MBProgressHUD showMessage:nil toView:self.view];
                     [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if ([code isEqualToString:@"1"]) {
                             [MBProgressHUD showSuccess:message toView:self.view];
                         } else {
                             //  [MBProgressHUD showError:message toView:self.view];
                         }
                         if (self.AShare_back) {
                             self.AShare_back();
                         }
                     } andFailure:^(NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                     }];
                 }
                 
                 break;
             case SSDKResponseStateFail:
                 //                 [MBProgressHUD showError:@"分享失败" toView:self.view];
                 break;
             case SSDKResponseStateCancel:
                 //                 [MBProgressHUD showError:@"分享取消" toView:self.view];
                 break;
             default:
                 break;
         }
     }];
}

- (UIImage *) getImageFromURL:(NSString *)fileURL {

    NSLog(@"执行图片下载函数");

    UIImage * result;



    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];

    result = [UIImage imageWithData:data];

    if (fileURL == nil||[fileURL isEqualToString:@""]) {
        return [UIImage imageNamed:@"无界优品默认空视图"];
    }


    return result;

}



@end
