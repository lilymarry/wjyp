//
//  SAWebPageController.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAWebPageController.h"
#import <WebKit/WebKit.h>

@interface SAWebPageController ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation SAWebPageController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    adjustsScrollViewInsets_NO(_webView, self);
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - NAVIGATION_BAR_HEIGHT)];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [MBProgressHUD showMessage:@"" toView:self.webView];
    NSString *urlStr = nil;
    switch (_type) {
        case WEB_PAGE_TYPE_XUFEI_SUCCESS:
        {
            urlStr = [NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Wap/User/success/status/1",[Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        }
            break;
        case WEB_PAGE_TYPE_XUFEI_FAILURE:{
            urlStr = [NSString stringWithFormat:@"http://%@.wujiemall.com/index.php/Wap/User/success/status/0",[Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        }
            break;
        default:
            break;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    [self createNav];
}

- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
