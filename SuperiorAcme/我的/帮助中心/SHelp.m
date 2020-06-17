//
//  SHelp.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHelp.h"
#import "SHelp_header.h"
#import "SHelpCell.h"
#import "SHelp_NewContent.h"
#import "SNPageView.h"
#import "SArticleHelpCenter.h"

@interface SHelp ()
{
    SHelp_NewContent * content;
}

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation SHelp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HelpCenter_url]]];
    NSLog(@"AAA _  %@",HelpCenter_url);
    [self.view addSubview:_webView];
    
    
//    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
//    pageView.subViews = @[[SHelp_NewContent class],[SHelp_NewContent class],[SHelp_NewContent class]];
//    pageView.titles = @[@"商家篇",@"用户篇",@"运营中心篇"];
//    pageView.titleWidth = ScreenW/3;
//    pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
//    pageView.sliderColor = WordColor;
//    pageView.defaultSelectedIndex = 0;
//    pageView.goundNormalColor = [UIColor whiteColor];
//    __block SHelp * gSelf = self;
//    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
//
//        content = subView;
//        SArticleHelpCenter * center = [[SArticleHelpCenter alloc] init];
//        if (index == 0) {
//            center.type = @"1";
//        }
//        if (index == 1) {
//            center.type = @"2";
//        }
//        if (index == 2) {
//            center.type = @"3";
//        }
//        [MBProgressHUD showMessage:nil toView:gSelf.view];
//        [center sArticleHelpCenterSuccess:^(NSString *code, NSString *message, id data) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//            SArticleHelpCenter * center = (SArticleHelpCenter *)data;
//            [content showModel:center.data];
//            
//        } anFailure:^(NSError *error) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
//        }];
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(content.mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"帮助中心";
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
