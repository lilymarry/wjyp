//
//  SMessageInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMessageInfor.h"
#import<WebKit/WebKit.h>

#import "SAcademyAcademyInfo.h"//无界书院
#import "SArticleGetArticle.h"//注册 服务条款
#import "SUserCollectAddCollect.h"
#import "SUserCollectDelOneCollect.h"
#import "SUserMessageAnnounceInfo.h"//公告详情
#import "SPayForMerchantController.h"

@interface SMessageInfor () <WKNavigationDelegate,WKUIDelegate>
{
    WKWebView * wk_web;
    UIButton * rigthBtn;
    BOOL collect_isno;//NO未收藏 YES已收藏
}
@property (strong, nonatomic) IBOutlet UIScrollView *mScroll;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topView_HHH;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerImage_HHH;
@property (strong, nonatomic) IBOutlet UIView *mScroll_View;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mScroll_ViewHHH;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UILabel *collect_num_page_views;
@end

@implementation SMessageInfor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];

    _headerImage_HHH.constant = ScreenW;
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    wk_web.userInteractionEnabled = YES;
    wk_web.UIDelegate = self;
    wk_web.navigationDelegate = self;
    [_mScroll_View addSubview:wk_web];
    
    [self showModel];
}
- (void)showModel {
    [MBProgressHUD showMessage:nil toView:self.view];
    if (_academy_id != nil) {
        self.title = @"详情";
        
        rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rigthBtn.frame = CGRectMake(0, 0, 70, 50);
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //无界书院
        SAcademyAcademyInfo * info = [[SAcademyAcademyInfo alloc] init];
        info.academy_id = _academy_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [info sAcademyAcademyInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SAcademyAcademyInfo * info = (SAcademyAcademyInfo *)data;
                
                if ([info.data.is_collect isEqualToString:@"0"]) {
                    collect_isno = NO;
                    [rigthBtn setTitle:@"收藏" forState:UIControlStateNormal];
                } else {
                    collect_isno = YES;
                    [rigthBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                }
                
                _thisTitle.text = info.data.title;
                _source.text = [NSString stringWithFormat:@"来源：%@",info.data.source];
                _collect_num_page_views.text = [NSString stringWithFormat:@"%@人收藏     %@人浏览",info.data.collect_num,info.data.page_views];
                [_headerImage sd_setImageWithURL:[NSURL URLWithString:info.data.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                [wk_web loadHTMLString:info.data.content baseURL:nil];
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"服务条款"]) {
        
        SArticleGetArticle * info = [[SArticleGetArticle alloc] init];
        info.type = @"1";
        [MBProgressHUD showMessage:nil toView:self.view];
        [info sArticleGetArticleSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SArticleGetArticle * info = (SArticleGetArticle *)data;
                
                self.title = info.data.title;
                [wk_web loadHTMLString:info.data.content baseURL:nil];
                _topView.hidden = YES;
                _headerImage.hidden = YES;
                _headerImage_HHH.constant = 0;
                _topView_HHH.constant = 0;
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"公告消息"]) {
        SUserMessageAnnounceInfo * info = [[SUserMessageAnnounceInfo alloc] init];
        info.id = _id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [info sUserMessageAnnounceInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if ([code isEqualToString:@"1"]) {
                SArticleGetArticle * info = (SArticleGetArticle *)data;
                
                self.title = info.data.title;
                [wk_web loadHTMLString:info.data.content baseURL:nil];
                _topView.hidden = YES;
                _topView_HHH.constant = 0;
                _headerImage.hidden = YES;
                _headerImage_HHH.constant = 0;

            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"二维码"]) {
        NSData *jsonData = [_code_Url dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if (dic == nil) {
            //注册 或者 直接访问URL
            NSString *url = @"";
            NSString *title = @"";
            NSRange range = [_code_Url rangeOfString:@"User/mentorship"];
            if (range.location != NSNotFound) {
                title = @"拜师码";
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    SLand * land = [[SLand alloc] init];
                    UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                    [UIApplication sharedApplication].delegate.window.rootViewController = landNav;
                } else {
                    NSString *token = [[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token;
                    url = [NSString stringWithFormat:@"%@/token/%@", _code_Url, token];
                }
            } else {
                NSRange range = [_code_Url rangeOfString:@"Wap/OfflineStore/confirmation/stage_merchant_id"];
                if (range.location != NSNotFound) {
                    //商家码去付款
                    SPayForMerchantController * payvc = [[SPayForMerchantController alloc] init];
                    payvc.url = _code_Url;
                    [self.navigationController pushViewController:payvc animated:YES];
                } else {
                    title = @"注册新用户";
                    url = _code_Url;
                }
            }
            self.title = title;
            [wk_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        } else {
            NSNumber *typeNum = [dic valueForKey:@"type"] != nil ? [dic valueForKey:@"type"] : @-1;
            NSString *urlStr  = [dic valueForKey:@"url"] != nil ? [dic valueForKey:@"url"] : @"";
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

        _topView.hidden = YES;
        _topView_HHH.constant = 0;
        _headerImage.hidden = YES;
        _headerImage_HHH.constant = 0;
    }
    if ([_type isEqualToString:@"快递信息"]) {
        self.title = @"快递信息";
        [wk_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_code_Url]]];
        _topView.hidden = YES;
        _topView_HHH.constant = 0;
        _headerImage.hidden = YES;
        _headerImage_HHH.constant = 0;
    }
    if ([_type isEqualToString:@"广告链接"]) {
        self.title = @"无界优品";
        [wk_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_code_Url]]];
        _topView.hidden = YES;
        _topView_HHH.constant = 0;
        _headerImage.hidden = YES;
        _headerImage_HHH.constant = 0;
    }
    if ([_type isEqualToString:@"会员卡"]) {
        self.title = @"无界优品会员协议";
        SArticleGetArticle * info = [[SArticleGetArticle alloc] init];
        info.type = @"2";
        [MBProgressHUD showMessage:nil toView:self.view];
        [info sArticleGetArticleSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SArticleGetArticle * info = (SArticleGetArticle *)data;
                
                
                [wk_web loadHTMLString:info.data.content baseURL:nil];
                _topView.hidden = YES;
                _headerImage.hidden = YES;
                _headerImage_HHH.constant = 0;
                _topView_HHH.constant = 0;
                
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"积分协议"]) {
        self.title = @"系统自动兑换";
        
        [wk_web loadHTMLString:_code_Url baseURL:nil];
        _topView.hidden = YES;
        _headerImage.hidden = YES;
        _headerImage_HHH.constant = 0;
        _topView_HHH.constant = 0;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mScroll, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:            (UIWebViewNavigationType)navigationType
//{
//    NSLog(@"request:%@",request);
//    NSString *str = request.URL.absoluteString;
//    NSLog(@"H5链接:%@",str);
//    NSLog(@"标题:%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
//
//    return YES;
//}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        
        
        if ([_type isEqualToString:@"服务条款"]||[_type isEqualToString:@"会员卡"]||[_type isEqualToString:@"公告消息"]||[_type isEqualToString:@"二维码"]||[_type isEqualToString:@"快递信息"]||[_type isEqualToString:@"广告链接"]||[_type isEqualToString:@"积分协议"]) {
            CGFloat topH = NAVIGATION_BAR_HEIGHT;
            if ([_type isEqualToString:@"二维码"]) {
                   wk_web.frame = CGRectMake(0, 0, ScreenW, ScreenH - topH);
            }
            else
            {
                wk_web.frame = CGRectMake(0, 0, ScreenW, ScreenH - topH);
                _mScroll_ViewHHH.constant = ScreenH - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT;
            }
        } else {
            wk_web.frame = CGRectMake(0, _headerImage.frame.origin.y + ScreenW, ScreenW, heightStr.floatValue + 15);
            _mScroll_ViewHHH.constant = 100 + ScreenW + heightStr.floatValue + 15;
        }
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    [MBProgressHUD showError:message toView:self.view];
    completionHandler();
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
- (void)rigthBtnClick {
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
        collect.type = @"3";
        collect.id_val = _academy_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [collect sUserCollectAddCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                collect_isno = YES;
                [rigthBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                
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
        delCollect.type = @"3";
        delCollect.id_val = _academy_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [delCollect sUserCollectDelOneCollectSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                collect_isno = NO;
                [rigthBtn setTitle:@"收藏" forState:UIControlStateNormal];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}

@end
