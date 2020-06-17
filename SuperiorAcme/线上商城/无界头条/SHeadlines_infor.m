//
//  SHeadlines_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHeadlines_infor.h"
#import "SIndexHeadInfo.h"
#import<WebKit/WebKit.h>

@interface SHeadlines_infor () <WKNavigationDelegate>
{
    WKWebView * wk_web;
}
@property (strong, nonatomic) IBOutlet UIScrollView *mScroll;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIView *mScroll_View;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mScroll_ViewHHH;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UILabel *cTime;
@end

@implementation SHeadlines_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta); var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    wk_web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0) configuration:wkWebConfig];
    wk_web.userInteractionEnabled = YES;
    //ios的scrollview嵌套webview，解决事件冲突
//    如果你触摸的地方是webView，那么响应的只可能是webView，如果在webView之外，就是scrollview响应。
//    当然，如果webView滑动到边界了，再拉也会作用在scrollview上的。如果你设置webview不可滚动，那就没有任何问题了。
    wk_web.scrollView.scrollEnabled=NO;
    
    wk_web.navigationDelegate = self;
    [_mScroll_View addSubview:wk_web];
    
    SIndexHeadInfo * info = [[SIndexHeadInfo alloc] init];
    info.headlines_id = _headlines_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [info sIndexHeadInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SIndexHeadInfo * info = (SIndexHeadInfo *)data;
            
            _thisTitle.text = info.data.title;
            _source.text = [NSString stringWithFormat:@"来源：%@",info.data.source];
            [_headerImage sd_setImageWithURL:[NSURL URLWithString:info.data.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            _cTime.text = [NSString stringWithFormat:@"创建时间:%@\n修改时间:%@",info.data.create_time,info.data.update_time];
            [wk_web loadHTMLString:info.data.content baseURL:nil];
            
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        
        
        wk_web.frame = CGRectMake(0, _headerImage.frame.origin.y + 200, ScreenW, heightStr.floatValue + 15);
        _mScroll_ViewHHH.constant = 70 + 200 + heightStr.floatValue + 15;
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mScroll, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"无界头条";
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

@end
