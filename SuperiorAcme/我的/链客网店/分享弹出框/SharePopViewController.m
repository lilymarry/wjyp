//
//  SharePopViewController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SharePopViewController.h"
#import "ReLayoutSubViewButton.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "SUserShareBack.h"

@interface SharePopViewController ()
{
    UIImage *share_image;
}
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *WeChatBtn;
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *WeChatFriendBtn;
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *QQBtn;
@property (weak, nonatomic) IBOutlet ReLayoutSubViewButton *SinaBtn;

@end

@implementation SharePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _WeChatBtn.interTitleImageSpacing = 30;
    _WeChatFriendBtn.interTitleImageSpacing = 30;
    _QQBtn.interTitleImageSpacing = 30;
    _SinaBtn.interTitleImageSpacing = 30;
   
    if ([_fag isEqualToString:@"2"] ) {
       NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Distribution/DistributionShop/shop", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        NSString *urlStr=[NSString stringWithFormat:@"%@/g_id/%@/shop_id/%@.html",detail_Base_url, _mode.goods_id,_shopidMing];
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length!=0) {
            urlStr =[NSString stringWithFormat:@"%@/g_id/%@/shop_id/%@/invite_code/%@.html",detail_Base_url, _mode.goods_id,_shopidMing,invite_code];
        }
        _goodsName=_mode.goods_name;
        _share_content=_mode.goods_brief;
        _share_img=_mode.goods_img;
        _share_url=urlStr;
    }
    if ([_fag isEqualToString:@"3"] ) {
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Distribution/DistributionShop/shop", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        NSString *urlStr=[NSString stringWithFormat:@"%@/shop_id/%@.html",detail_Base_url,_shopidMing];
       
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length!=0) {
              urlStr =[NSString stringWithFormat:@"%@/shop_id/%@/invite_code/%@.html",detail_Base_url,_shopidMing,invite_code];
        }
        _share_url=urlStr;
        
    }
    
    if (_goods_id.length==0) {
        _goods_id=@"";
    }
    if (_share_img.length==0) {
       share_image=[UIImage imageNamed:@"无界优品默认空视图_方形"];
       
    }
    else
    {
        NSData *data = [NSData  dataWithContentsOfURL:[NSURL URLWithString:_share_img]];
        
       share_image =  [UIImage imageWithData:data];
    }
   
    
}

//点击隐藏
- (IBAction)HiddenShareView:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelShareGoodClick:(UIButton *)sender {
    [self HiddenShareView:nil];
}
- (IBAction)WeChatShare:(ReLayoutSubViewButton *)sender {
    NSLog(@"微信分享");
    [self twoBtnClick];
}
- (IBAction)WeChatFriendClick:(ReLayoutSubViewButton *)sender {
    NSLog(@"微信-朋友圈-分享");
    [self oneBtnClick];
}
- (IBAction)QQSahreClick:(ReLayoutSubViewButton *)sender {
    NSLog(@"QQ分享");
    [self threeBtnClick];
}
- (IBAction)SinaShareClick:(ReLayoutSubViewButton *)sender {
    NSLog(@"新浪分享");
    [self fourBtnClick];
}

//#pragma mark - 微信朋友圈
- (void)oneBtnClick {
  
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupWeChatParamsByText:_share_content title:_goodsName url:[NSURL URLWithString:_share_url] thumbImage:share_image image:share_image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         //         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:
                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                //     [MBProgressHUD showError:@"分享成功" toView:self.view];
                                              SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                                              shareBack.type = @"1";
                                              shareBack.content = _share_content;
                                              shareBack.id_val = _goods_id;
                                              shareBack.share_type = _share_type;
                                              shareBack.url = _share_url;
                                              [MBProgressHUD showMessage:nil toView:self.view];
                                              [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                  if ([code isEqualToString:@"1"]) {
                                                      [MBProgressHUD showSuccess:message toView:self.view];
                                                  } else {
                                                    //  [MBProgressHUD showError:@"分享成功"  toView:self.view];
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
    [shareParams SSDKSetupWeChatParamsByText:_share_content title:_goodsName url:[NSURL URLWithString:_share_url] thumbImage:share_image image:share_image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
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
                         shareBack.content = _share_content;
                         shareBack.id_val = _goods_id;
                         shareBack.share_type = _share_type;
                         shareBack.url = _share_url;
                         [MBProgressHUD showMessage:nil toView:self.view];
                         [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             if ([code isEqualToString:@"1"]) {
                                 [MBProgressHUD showSuccess:message toView:self.view];
                             } else {
                               //  [MBProgressHUD showError:@"分享成功"  toView:self.view];
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
    [shareParams SSDKSetupQQParamsByText:_share_content title:_goodsName url:[NSURL URLWithString:_share_url] thumbImage:share_image image:share_image type:SSDKContentTypeWebPage forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
    [ShareSDK share:SSDKPlatformSubTypeQQFriend
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         //         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:
                 
                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                    // [MBProgressHUD showError:@"分享成功" toView:self.view];
                    
                         SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                         shareBack.type = @"3";
                         shareBack.content =_share_content;
                         shareBack.id_val = _goods_id;
                         shareBack.share_type = _share_type;
                         shareBack.url = _share_url;
                         [MBProgressHUD showMessage:nil toView:self.view];
                         [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             if ([code isEqualToString:@"1"]) {
                                 [MBProgressHUD showSuccess:message toView:self.view];
                             } else {
                               //  [MBProgressHUD showError:@"分享成功"  toView:self.view];
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
    [shareParams SSDKSetupSinaWeiboShareParamsByText:_share_content title:_goodsName image:share_image url:[NSURL URLWithString:_share_url] latitude:0 longitude:0 objectID:@"" type:SSDKContentTypeImage];
    
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         //         [self backClick];
         NSLog(@"%@",error);
         switch (state) {
             case SSDKResponseStateSuccess:
                 //1 商品 2商家 3书院 4红包 5其他(个人中心)
                 if (state == SSDKResponseStateSuccess) {
                  //   [MBProgressHUD showError:@"分享成功" toView:self.view];
                         SUserShareBack * shareBack = [[SUserShareBack alloc] init];
                         shareBack.type = @"2";
                         shareBack.content = _share_content;
                         shareBack.id_val = _goods_id;
                         shareBack.share_type = _share_type;
                         shareBack.url = _share_url;
                         [MBProgressHUD showMessage:nil toView:self.view];
                         [shareBack sUserShareBackSuccess:^(NSString *code, NSString *message) {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             if ([code isEqualToString:@"1"]) {
                                 [MBProgressHUD showSuccess:message toView:self.view];
                             } else {
                              //   [MBProgressHUD showError:@"分享成功"  toView:self.view];
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


@end
