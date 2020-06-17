//
//  SlineDetailWebController.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SlineDetailWebController.h"
#import<WebKit/WebKit.h>

#import "SharePopViewController.h"
#import "SPayGetAlipayParam.h"
#import "SNPayManager.h"
#import "SPayGetAlipayParam.h"//获取支付宝支付参数
#import "SPayFindPayResult.h"//订单支付查询
#import "SPayGetJsTine.h"//获取微信支付参数
#import "SNTabBarController.h"
#import "SlineDetailWebModel.h"
#import "EaseMessageViewController.h"
#import "ZLPhoto.h"

#import "HSQActionSheet.h"
#import <BaiduMapAPI_Utils/BMKOpenRouteOption.h>
#import <BaiduMapAPI_Utils/BMKOpenRoute.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "UIView+customGetCurrentUIViewController.h"

#import "CustomLayoutConstraint.h"
#import "SOrderCenter_list.h"
#import "SPay.h"
#import "AShare.h"
#import "SlineWebPrint.h"
#import "SPayForMerchantController.h"

#import "SPhotoVC.h"
#import "GoodsManager.h"
#import "SOrderCenter.h"
#import "OsManagerBflist.h"
#import "SLineShop.h"
@interface SlineDetailWebController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UIImagePickerControllerDelegate,HSQActionSheetDelegate>
{
    
    UIImagePickerController * _imagePickerPhoto;
    UIImagePickerController * _imagePickerCamera;
    NSMutableArray *saveArr;
    BOOL allowMutSelect;
    
    BOOL _isInstallGaoDeMap; //高德
    BOOL _isInstallBaiDuMap; //百度
    BOOL _isInstallSystomMap; //系统
    
    float baiDuLat;
    float baiDuLng;
    float gaoDeLat;
    float gaoDeLng;
    
    int width;
    int height;
    
}

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation SlineDetailWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    saveArr =[NSMutableArray array];
    
    if ([_fag isEqualToString:@"9"])
    {
        self.title=@"集碎片";
    }
    
    if ([_fag isEqualToString:@"11"])
    {
        self.title=@"收益明细";
    }
    if ([_fag isEqualToString:@"10"])
    {
        self.title=@"店铺消息";
    }
    if ([_fag isEqualToString:@"12"])
    {
        self.title=@"紫薇斗数";
    }
    if ([_fag isEqualToString:@"15"])
    {
        self.title=@"线下店铺";
    }
    
    [self refreshWebView];
    [self createNav];
    
}

-(void)refreshWebView
{
    
    
    WKWebViewConfiguration*   _config = [[WKWebViewConfiguration alloc]init];
    _config.userContentController = [[WKUserContentController alloc]init];
    //webViewAppShare这个需保持跟服务器端的一致，服务器端通过这个name发消息，客户端这边回调接收消息，从而做相关的处理
    double yy;
    if (KIsiPhoneX) {
        yy = 88;
    } else {
        yy = 64;
    }
    if ([_fag isEqualToString:@"8"]||[_fag isEqualToString:@"10"]) {
        if (KIsiPhoneX) {
            yy = 44;
        } else {
            yy=20;
        }
        
    }
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, yy,ScreenW ,ScreenH-yy)configuration: _config];
    
     _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [request setValue:@"ios"
   forHTTPHeaderField:@"device"];
    [request setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token
   forHTTPHeaderField:@"token"];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
  //  [self scanERweiMa];
    
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
-(void)lefthBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)scanERweiMa
{
    if ([_fag isEqualToString:@"2"]) {
        NSData *jsonData = [_urlStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if (dic == nil) {
            //注册 或者 直接访问URL
            NSString *url = @"";
            NSString *title = @"";
            NSRange range = [_urlStr rangeOfString:@"User/mentorship"];
            if (range.location != NSNotFound) {
                title = @"拜师码";
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    SLand * land = [[SLand alloc] init];
                    UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                    [UIApplication sharedApplication].delegate.window.rootViewController = landNav;
                } else {
                    NSString *token = [[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token;
                    url = [NSString stringWithFormat:@"%@/token/%@", _urlStr, token];
                }
            } else {
                NSRange range = [_urlStr rangeOfString:@"Wap/OfflineStore/confirmation/stage_merchant_id"];
                if (range.location != NSNotFound) {
                    //商家码去付款
                    SPayForMerchantController * payvc = [[SPayForMerchantController alloc] init];
                    payvc.url = _urlStr;
                    [self.navigationController pushViewController:payvc animated:YES];
                } else {
                    //  title = @"注册新用户";
                    url = _urlStr;
                }
            }
            self.title = title;
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        } else {
            NSNumber *typeNum = [dic valueForKey:@"type"] != nil ? [dic valueForKey:@"type"] : @-1;
            //    NSString *urlStr  = [dic valueForKey:@"url"] != nil ? [dic valueForKey:@"url"] : @"";
            if ([typeNum integerValue] == 3) {
                //下载app
                self.title = @"下载APP";
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                //            [wk_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
            } else if ([typeNum integerValue] == 1) {
                //登录
                self.title = @"扫码登录";
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    SLand * land = [[SLand alloc] init];
                    UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                    [UIApplication sharedApplication].delegate.window.rootViewController = landNav;
                } else {
                    [HttpManager postWithUrl:ScanQRCodeLogin_url andParameters:@{@"sid":dic[@"data"][@"sid"]} andSuccess:^(id Json) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        NSDictionary * dic = (NSDictionary *)Json;
                        if ([dic[@"code"] isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
                        } else {
                            [MBProgressHUD showError:@"登录失败" toView:self.view];
                        }
                    } andFail:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:@"登录失败" toView:self.view];
                    }];
                }
            }
        }
        
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addAllScriptMsgHandle];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    if ([_fag isEqualToString:@"8"]||[_fag isEqualToString:@"10"]) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self removeAllScriptMsgHandle];
    if ([_fag isEqualToString:@"8"]||[_fag isEqualToString:@"10"]) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}
-(void)addAllScriptMsgHandle{
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller addScriptMessageHandler:self name:@"toLogin"];//登录
    [controller addScriptMessageHandler:self name:@"toShare"];//分享
    [controller addScriptMessageHandler:self name:@"payForApplication"];//支付
    [controller addScriptMessageHandler:self name:@"toOfflinePage"];//线下店铺首页
    [controller addScriptMessageHandler:self name:@"toPersonalCenter"];//个人中心
    [controller addScriptMessageHandler:self name:@"topenPhotoFolder"];//相册
    [controller addScriptMessageHandler:self name:@"openCamera"];//摄像
    [controller addScriptMessageHandler:self name:@"toChat"];//聊天
    [controller addScriptMessageHandler:self name:@"downImageToPhone"];//保存图片到相册
    [controller addScriptMessageHandler:self name:@"mapLocation"];//手机导航
    [controller addScriptMessageHandler:self name:@"toSplicingOrder"];//订单中心 集碎片
    [controller addScriptMessageHandler:self name:@"setOrder"];//支付订单 集碎片
    [controller addScriptMessageHandler:self name:@"hiddenKeyBoard"];//隐藏键盘
    [controller addScriptMessageHandler:self name:@"callTell"];//拨打电话
    [controller addScriptMessageHandler:self name:@"toPrint"];//打印设备
    [controller addScriptMessageHandler:self name:@"toGoodsManager"];//商品管理
    [controller addScriptMessageHandler:self name:@"toFriend"];//以商会友
    [controller addScriptMessageHandler:self name:@"toSOrderCenter"];//订单中心
    
}
-(void)removeAllScriptMsgHandle{
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller removeScriptMessageHandlerForName:@"toLogin"];
    [controller removeScriptMessageHandlerForName:@"toShare"];
    [controller removeScriptMessageHandlerForName:@"payForApplication"];
    [controller removeScriptMessageHandlerForName:@"toOfflinePage"];
    [controller removeScriptMessageHandlerForName:@"toPersonalCenter"];
    [controller removeScriptMessageHandlerForName:@"topenPhotoFolder"];
    [controller removeScriptMessageHandlerForName:@"openCamera"];
    [controller removeScriptMessageHandlerForName:@"toChat"];
    [controller removeScriptMessageHandlerForName:@"downImageToPhone"];
    [controller removeScriptMessageHandlerForName:@"mapLocation"];
    [controller removeScriptMessageHandlerForName:@"toSplicingOrder"];
    [controller removeScriptMessageHandlerForName:@"setOrder"];
    [controller removeScriptMessageHandlerForName:@"hiddenKeyBoard"];
    [controller removeScriptMessageHandlerForName:@"callTell"];
    [controller removeScriptMessageHandlerForName:@"toPrint"];
    [controller removeScriptMessageHandlerForName:@"toGoodsManager"];
    [controller removeScriptMessageHandlerForName:@"toFriend"];
    [controller removeScriptMessageHandlerForName:@"toSOrderCenter"];
    
    
}
#pragma mark js交互方法

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
{
    NSLog(@"dff %@",message.name);
    
#pragma mark 登录
    if ([message.name isEqualToString:@"toLogin"]) {
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:message.body options:0];
        NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
        
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        land.fag=_fag;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:decodedString]]];
            [_webView reload];
        };
        return;
        
    }
#pragma mark 分享
    if ([message.name isEqualToString:@"toShare"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        AShare * shareVC = [[AShare alloc] init];
        shareVC.thisImage=dic[@"share_img"];
        shareVC.thisTitle = dic[@"goodsName"];
        shareVC.thisContent = dic[@"share_content"];
        shareVC.thisUrl = dic[@"share_url"];
        if(dic[@"id"]!=nil)
        {
            shareVC.id_val=dic[@"id"];
        }
        else
        {
            shareVC.id_val=@"";
        }
        
        if (dic[@"share_type"]!=nil ) {
            shareVC.thisType=dic[@"share_type"];
        }
        else
        {
            shareVC.thisType=@"1";
        }
        shareVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        shareVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:shareVC animated:YES completion:nil];
        __block AShare * gSelf = shareVC;
        shareVC.AShare_back = ^{      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1.0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.webView reload];
                [gSelf backClick];
            });
        });
        };
    }
#pragma mark 微信与支付宝支付
    if ([message.name isEqualToString:@"payForApplication"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if ([dic[@"pay_type"] isEqualToString:@"Alipay"]) {
            [self payAlipay:dic];
        }
        else
        {
            [self payWeChat:dic];
        }
        
    }
#pragma mark 线下商城首页
    if ([message.name isEqualToString:@"toOfflinePage"]) {
        
        SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
        self.view.window.rootViewController = tabBarController;
        tabBarController.selectedIndex=1;
    }
#pragma mark 个人中心
    if ([message.name isEqualToString:@"toPersonalCenter"]) {
        
        SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
        self.view.window.rootViewController = tabBarController;
        tabBarController.selectedIndex=3;
        
    }
#pragma mark 相册
    if ([message.name isEqualToString:@"topenPhotoFolder"]) {
        //  NSLog(@"dfdsfsdf %@",message.body);
        
        if (SWNOTEmptyStr(message.body))
        {
            if ([message.body isEqualToString:@"0"]) {
                allowMutSelect=NO;
            }
            else if ([message.body isEqualToString:@"1"])
            {
                allowMutSelect=YES;
            }
            else
            {
                NSArray *array = [message.body componentsSeparatedByString:@","];
                
                NSString  *type=[self getSubStr:array[0]withTap:@"1"];
                if ([type isEqualToString:@"0"]) {
                    allowMutSelect=NO;
                }
                else
                {
                    allowMutSelect=YES;
                }
                
                width= [[self getSubStr:array[1]withTap:@"1"]intValue];
                height= [[self getSubStr:array[2]withTap:@"2"]intValue];
            }
            if (allowMutSelect) {
                [self choiceMutSelectImageView];
            }
            else
            {
                //打开相册
                _imagePickerPhoto = [[UIImagePickerController alloc] init];
                _imagePickerPhoto.delegate = self;
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
                
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    _imagePickerPhoto.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    _imagePickerPhoto.allowsEditing = YES;
                    [self presentViewController:_imagePickerPhoto animated:YES completion:nil];
                }
            }
            
            
        }
        
    }
#pragma mark 照相机
    if ([message.name isEqualToString:@"openCamera"]) {
        if (SWNOTEmptyStr(message.body))
        {
            NSArray *array = [message.body componentsSeparatedByString:@","];
            width= [[self getSubStr:array[1]withTap:@"1"]intValue];
            height= [[self getSubStr:array[2]withTap:@"2"]intValue];
        }
        _imagePickerCamera = [[UIImagePickerController alloc] init];
        _imagePickerCamera.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            _imagePickerCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
            CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.25, 1.25);
            _imagePickerCamera.cameraViewTransform = cameraTransform;
            
            _imagePickerCamera.allowsEditing = YES;
            [self presentViewController:_imagePickerCamera animated:YES completion:nil];
        }
        
    }
    
#pragma  mark 聊天
    if ([message.name isEqualToString:@"toChat"]) {
        
        
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:dic[@"userId"] conversationType:EMConversationTypeChat];
        chatController.title = dic[@"userName"];
        chatController.nickname_mine =  dic[@"myName"];
        chatController.pic_mine =  dic[@"myHead"];
        chatController.nickname_other = dic[@"userName"];
        chatController.pic_other =  dic[@"userHead"];
        [self.navigationController pushViewController:chatController  animated:YES ];
    }
#pragma  mark 图片下载
    if ([message.name isEqualToString:@"downImageToPhone"]) {
        
        
        if (NOTNULL(message.body)||SWNOTEmptyArr(message.body)||SWNOTEmptyStr(message.body)||SWNOTEmptyDictionary(message.body)) {
            
            
            NSString* encodedString = [message.body stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//URL 含有中文 encode 编码
            NSURL * url = [NSURL URLWithString:encodedString];
            
            NSData *data=[NSData dataWithContentsOfURL:url];
            UIImage *iamge=[UIImage imageWithData:data];
            UIImageWriteToSavedPhotosAlbum(iamge, self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
            
            
        }
    }
#pragma mark 地图导航
    if ([message.name isEqualToString:@"mapLocation"]) {
        
        
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        
        baiDuLat=[dic[@"baiDuLat"] floatValue];
        baiDuLng=[dic[@"baiDuLng"] floatValue];
        gaoDeLat=[dic[@"gaoDeLat"] floatValue];
        gaoDeLng=[dic[@"gaoDeLng"] floatValue];
        [self daoHangBtnClick];
    }
#pragma mark 集碎片的订单中心
    if ([message.name isEqualToString:@"toSplicingOrder"]) {
        
        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
        list.type = @"16";
        list.coming = YES;
        [self.navigationController pushViewController:list animated:YES];
        
    }
    
#pragma mark 集碎片的付款
    if ([message.name isEqualToString:@"setOrder"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        SPay * pay = [[SPay alloc] init];
        pay.model_type = @"普通商品";
        pay.order_id=dic[@"order_id"];
        pay.IsSuiPian=YES;
        pay.IsSuiPianWeb=YES;
        [self.navigationController pushViewController:pay animated:YES];
        
    }
#pragma mark 隐藏键盘
    if ([message.name isEqualToString:@"hiddenKeyBoard"]) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
    }
#pragma mark 打电话
    if ([message.name isEqualToString:@"callTell"]) {
        NSDictionary *dic =message.body;
        NSString *phone=[NSString stringWithFormat:@"%@",dic[@"tel"]];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phone];
        NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
        if (compare == NSOrderedDescending || compare == NSOrderedSame) {
            /// 大于等于10.0系统使用此openURL方法
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            }
        } else {
            NSString *callPhone = [NSString stringWithFormat:@"tel:%@",phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }
#pragma mark 打印
    if ([message.name isEqualToString:@"toPrint"]) {
        SlineWebPrint *print=[[SlineWebPrint alloc]init];
        [self.navigationController pushViewController:print animated:YES];
    }
#pragma mark 商品管理
    if ([message.name isEqualToString:@"toGoodsManager"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        GoodsManager  *mana=[[GoodsManager alloc]init];
        mana.sta_mid=[NSString stringWithFormat:@"%@",dic[@"sta_mid"]];
        [self.navigationController pushViewController:mana animated:YES];
    }
    
#pragma mark 以商会友
    if ([message.name isEqualToString:@"toFriend"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        OsManagerBflist  *mana=[[OsManagerBflist alloc]init];
        mana.sta_mid=[NSString stringWithFormat:@"%@",dic[@"sta_mid"]];
        mana.type=[NSString stringWithFormat:@"%@",dic[@"type"]];
        [self.navigationController pushViewController:mana animated:YES];
    }
#pragma mark 订单中心
    if ([message.name isEqualToString:@"toSOrderCenter"]) {
        [self .navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark WKUIDelegate
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
//作为js中confirm接口的实现，需要有提示信息以及两个相应事件， 确认及取消，并且在completionHandler中回传相应结果，确认返回YES， 取消返回NO
//参数 message为  js 方法 confirm(<message>) 中的<message>
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

//作为js中prompt接口的实现，默认需要有一个输入框一个按钮，点击确认按钮回传输入值
//当然可以添加多个按钮以及多个输入框，不过completionHandler只有一个参数，如果有多个输入框，需要将多个输入框中的值通过某种方式拼接成一个字符串回传，js接收到之后再做处理

//参数 prompt 为 prompt(<message>, <defaultValue>);中的<message>
//参数defaultText 为 prompt(<message>, <defaultValue>);中的 <defaultValue>
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




#pragma mark WKNavigationDelegate  //该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    [MBProgressHUD showMessage:@"" toView:self.view];
    if ([_fag isEqualToString:@"16"])
    {
        [MBProgressHUD showSuccess:@"请先完善店铺信息设置营业时间" toView:self.view];
        _fag=@"";
    }
  
}
//3. 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    //  NSLog(@"当内容开始返回时调用");
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

//// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation

{
    NSLog(@"页面加载失败时调用");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@",error);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@",error);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    // 被取消
    if([error code] == NSURLErrorCancelled)  {
        return;
    }
    
}

// // 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSMutableURLRequest *mutableRequest = [navigationAction.request mutableCopy];
    NSDictionary *requestHeaders = navigationAction.request.allHTTPHeaderFields;
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];

//    if ([strRequest containsString:@"Address/addressList"]||[strRequest containsString:@"shoppingCart/buyType"]) {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    if (![_fag isEqualToString:@"9"]) {
          decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    else if(![_fag isEqualToString:@"12"])
    {
         decisionHandler(WKNavigationActionPolicyAllow);
    }
    else
    {
        //我们项目使用的token同步的，cookie的话类似
        if (requestHeaders[@"token"]||requestHeaders[@"device"]){

            //拦截特殊的URL
            if ([strRequest containsString:@"sqkd_list"]||[strRequest containsString:@"OsManager/os_sub"]) {
                decisionHandler(WKNavigationActionPolicyCancel);
            }else {

                decisionHandler(WKNavigationActionPolicyAllow);
            }

        }else{
            //这里添加请求头，把需要的都添加进
            [mutableRequest setValue:@"ios"
                  forHTTPHeaderField:@"device"];
            [mutableRequest setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token
                  forHTTPHeaderField:@"token"];
            [webView loadRequest:mutableRequest];
         decisionHandler(WKNavigationActionPolicyAllow);//允许跳转

        }}
}

#pragma mark - 相册多图
- (void)choiceMutSelectImageView {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    if (allowMutSelect) {
        pickerVc.maxCount = 9;
    }
    [saveArr removeAllObjects];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = NO;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        for (int i = 0; i < status.count; i++) {
            id assets = status[i];
            if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
               UIImage *   scaleImage = [self zipIma:ddd.originImage];
                [saveArr addObject:scaleImage];
            }
        }
        
        [self upLoadImage:saveArr];
    };
    [pickerVc showPickerVc:self];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
#pragma mark 照相
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //设置只可拍照
        _imagePickerCamera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
        NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
           
            [saveArr removeAllObjects];
            UIImage * imageCamera = info[UIImagePickerControllerEditedImage];
            
            SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
            UIImageWriteToSavedPhotosAlbum(imageCamera, self,selectorToCall, nil);
            UIImage * scaleImage;
            if (width!=0&&height!=0) {
                scaleImage = [self scaleToSize:imageCamera size:CGSizeMake(width, height)];
                [saveArr addObject:scaleImage];
                
            }
            else{
                scaleImage = [self zipIma:imageCamera];
                [saveArr addObject:scaleImage];
            }
            [self upLoadImage:saveArr];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    else
    {
#pragma mark 单图
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            NSString * sourceType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([sourceType isEqualToString:(NSString *)kUTTypeImage]) {
          
               [saveArr removeAllObjects];
          
              UIImage * imagePhoto = info[UIImagePickerControllerEditedImage];
              //  UIImage * imagePhoto = info[ UIImagePickerControllerOriginalImage];
               
                UIImage * scaleImage;
                if (width!=0&&height!=0) {
                    scaleImage = [self scaleToSize:imagePhoto size:CGSizeMake(width, height)];
                    [saveArr addObject:scaleImage];
                }
                else
                {
                    scaleImage = [self zipIma:imagePhoto];
                    [saveArr addObject:scaleImage];
                }
             //    SEL selectorToCall = @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:);
             //   UIImageWriteToSavedPhotosAlbum(scaleImage, self,selectorToCall, nil);
                [self upLoadImage:saveArr];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
    }
}
- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [MBProgressHUD showSuccess:@"已成功保存到相册!" toView:[UIApplication sharedApplication].delegate.window];
}

//压缩图片为指定大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

-(UIImage *)zipIma:(UIImage *)image
{
    CGSize imagesize = image.size;
    float XX=imagesize.width/ScreenW;//宽度比
    float VY=imagesize.height/XX;//在屏幕上的高度
    imagesize.width = ScreenW;//放大倍数
    imagesize.height =VY;
    UIImage *ima = [self scaleToSize:image size:imagesize];
    
    return ima;
}
- (void)imageWasSavedSuccessfully:(UIImage *)cameraImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo
{
    
    if (paramError == nil){
        
        NSLog(@"保存相册成功");
        
    } else {
        
        NSLog(@"保存相册时发生错误");
        NSLog(@"Error = %@", paramError);
    }
}
#pragma mark 上传图片
- (void)upLoadImage:(NSArray *)cImageArr
{
    if (cImageArr.count<=0) {
        return;
    }
    SlineDetailWebModel *model=[[SlineDetailWebModel alloc]init];
    model.save_path=@"";
    model.ImagesAndNames =cImageArr;
    model.keyName=@"logo_";
     [MBProgressHUD showMessage:nil toView:self.view];
    [model SlineDetailWebModelSuccess:^(NSString *code, NSString *message, NSString * jsonStr) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code intValue]==1) {
            //OC调用JS
            NSString *str  = [NSString stringWithFormat:@"TakePhoto('%@')",jsonStr];
            
            [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                
            }];
        }
        else
        {
            [MBProgressHUD showError:message toView:self.view];
        }
        
    } andFailure:^(NSError *error) {
        
    }];
    
}

#pragma mark 支付
-(void)payAlipay:(NSDictionary *)dic
{
    SPayGetAlipayParam * getPay = [[SPayGetAlipayParam alloc] init];
    if ([dic[@"type"] intValue]==17) {
        getPay.order_id = dic[@"divination_id"];
        getPay.discount_type=dic[@"divination_type"];
    }
    else
    {
        getPay.order_id = dic[@"order_id"];
        getPay.discount_type=dic[@"discount_type"];
    }
    getPay.type=[NSString stringWithFormat:@"%d",[dic[@"type"] intValue]];
    [MBProgressHUD showMessage:nil toView:self.view];
    [getPay sPayGetAlipayParamSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SPayGetAlipayParam * getPay = (SPayGetAlipayParam *)data;
        [[SNPayManager sharePayManager] sn_openTheAlipayOrderString:getPay.data.pay_string WithServicePay:^(NSError *error) {
            if (!error) {
                //紫薇斗数 支付成功
                if ([dic[@"type"] intValue ]==17)
                {
                    NSString *   detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com%@", [Url_header isEqualToString:@"api"] ? @"www" : Url_header,dic[@"reurl"]];
                    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detail_Base_url]]];
                    [_webView reload];
                    
                }
                else
                {
                    [self payShowWithData:dic];
                }
            }
            else
            {
                if ([dic[@"type"] intValue ]==17)
                {
                    NSString *   detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com%@", [Url_header isEqualToString:@"api"] ? @"www" : Url_header,dic[@"faileurl"]];
                    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detail_Base_url]]];
                    [_webView reload];
                }
                else
                {
                    [self payShowWithData:dic];
                }
            }
            
        }
         ];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        
    }];
}
-(void)payWeChat:(NSDictionary *)dic
{
    SPayGetJsTine * tine = [[SPayGetJsTine alloc] init];
    if ([dic[@"type"] intValue]==17) {
        tine.order_id = dic[@"divination_id"];
        tine.discount_type=dic[@"divination_type"];
    }
    else
    {
        tine.order_id = dic[@"order_id"];
        tine.discount_type=dic[@"discount_type"];
    }
    
    
    tine.type=[NSString stringWithFormat:@"%d",[dic[@"type"] intValue]];
    tine.money = @"";
    [MBProgressHUD showMessage:nil toView:self.view];
    [tine sPayGetJsTineSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        SPayGetJsTine * tine = (SPayGetJsTine *)data;
        SNPayManager * manager = [SNPayManager sharePayManager];
        manager.wxPartnerId = tine.data.mch_id;//商户号
        manager.wxPrepayId = tine.data.prepay_id;//预支付id
        manager.wxNonceStr = tine.data.nonce_str;//随机字符串
        manager.wxTimeStamp = tine.data.time_stamp;//时间戳
        manager.wxSign = tine.data.sign;//签名
        [manager sn_openTheWechatWithServicePay:^(NSError *error) {
            if (!error) {
                //紫薇斗数 支付成功
                if ([dic[@"type"] intValue ]==17)
                {
                    NSString *   detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com%@", [Url_header isEqualToString:@"api"] ? @"www" : Url_header,dic[@"reurl"]];
                    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detail_Base_url]]];
                    [_webView reload];
                    
                }
                else
                {
                    [self payShowWithData:dic];
                }
            }
            else
            {
                if ([dic[@"type"] intValue ]==17)
                {
                    NSString *   detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com%@", [Url_header isEqualToString:@"api"] ? @"www" : Url_header,dic[@"faileurl"]];
                    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detail_Base_url]]];
                    [_webView reload];
                }
                else
                {
                    [self payShowWithData:dic];
                }
            }
            
        }
         ];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

#pragma mark - 支付结果查询
- (void)payShowWithData:(NSDictionary *)dic {
    SPayFindPayResult * result = [[SPayFindPayResult alloc] init];
    result.order_id =dic[@"order_id"];
    result.type = [NSString stringWithFormat:@"%d",[dic[@"type"] intValue]];
    [MBProgressHUD showMessage:nil toView:self.view];
    [result sPayFindPayResultSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SPayFindPayResult * result = (SPayFindPayResult *)data;
        if ([result.data.status intValue]==1) {
     //       NSString *url;
            //20 保证金充值
     //       if ([dic[@"type"] intValue]==20) {
           NSString *  url =result.data.jump_url;
  //          }
//            else
//            {
//                NSString *   detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/Pay/pay_back/order/", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
//
//                url=[NSString stringWithFormat:@"%@/%@.html",detail_Base_url,result.data.order_sn];
//            }
            
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            [_webView reload];
            
        } else {
            [MBProgressHUD showError:@"支付失败" toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

#pragma mark 地图导航
- (void)daoHangBtnClick{
    /*
     高德 百度 系统自带的地图   没有该地图的不显示
     */
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        _isInstallGaoDeMap = YES;
    } else {
        _isInstallGaoDeMap = NO;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        _isInstallBaiDuMap = YES;
    } else {
        _isInstallBaiDuMap = NO;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]) {
        _isInstallSystomMap = YES;
    } else {
        _isInstallSystomMap = NO;
    }
    
    [self chaXunMapAppMethod];
}

- (void)chaXunMapAppMethod{
    NSMutableArray *installMaps = [NSMutableArray array];
    
    if (_isInstallGaoDeMap) {
        [installMaps addObject:@"高德地图"];
    }
    
    if(_isInstallBaiDuMap){
        [installMaps addObject:@"百度地图"];
    }
    
    if(_isInstallSystomMap){
        [installMaps addObject:@"系统地图"];
    }
    
    HSQActionSheet *actionSheet = [HSQActionSheet actionSheetWithTitle:nil
                                                              confirms:installMaps
                                                                cancel:@"取消"
                                                                 style:HSQActionSheetStyleDefault];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

#pragma mark - 点击导航进入各个地图
- (void)clickAction:(HSQActionSheet *)actionSheet atIndex:(NSUInteger)index{
    if (index == 0) {
        if (_isInstallGaoDeMap) {
            [self openGaoDeMap];
        }else if (_isInstallBaiDuMap){
            [self openBaiDuMap];
        }else if(_isInstallSystomMap){
            [self openSystomMap];
        }
        
    }else if (index == 1){
        if (_isInstallBaiDuMap){
            [self openBaiDuMap];
        }else if(_isInstallSystomMap){
            [self openSystomMap];
        }
    }else if(index == 2){
        if(_isInstallSystomMap){
            [self openSystomMap];
        }
    }
}

- (void)openBaiDuMap{
    NSString *baiduParameterFormat = @"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=driving";
    NSString *urlString = [NSString stringWithFormat:baiduParameterFormat,0,0,baiDuLat,baiDuLng,@""];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
}

- (void)openGaoDeMap{  //驾车 骑车
    
    NSString *urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=wujie&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",gaoDeLat,gaoDeLng,@""];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *myLocationScheme = [NSURL URLWithString:urlString];
    //iOS10以后,使用新API
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:myLocationScheme options:@{ } completionHandler:^(BOOL success) {  }];
    }    else {
        //iOS10以前,使用旧API
        [[UIApplication sharedApplication] openURL:myLocationScheme];
    }
}

- (void)openSystomMap{
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(gaoDeLat,gaoDeLng) addressDictionary:nil]]; //目的地坐标
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:NO]}];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lastView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)dealloc
{
    NSLog(@"************************delloc");
}
-(NSString *)getSubStr:(NSString *)str withTap:(NSString *)tap
{
    //截取一段
    if ([tap isEqualToString:@"1"]) {
        NSRange range = [str rangeOfString:@":"];
        NSString *  string = [str substringFromIndex:range.location+range.length];
     
        return string;
    }
    else
    {
        NSRange startRange = [str rangeOfString:@":"];
        
        NSRange endRange = [str rangeOfString:@"}"];
        
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        
        NSString *result = [str substringWithRange:range];
       
        return result;
    }
    
}

@end
