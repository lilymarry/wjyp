//
//  SAboutUs.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAboutUs.h"
#import "SArticleAboutUs.h"

@interface SAboutUs ()

@property (strong, nonatomic) IBOutlet UILabel *thisNum;
@property (strong, nonatomic) IBOutlet UILabel *company_name;
@property (strong, nonatomic) IBOutlet UILabel *copyright;
@property (weak, nonatomic) IBOutlet UIImageView *thisLogo;
@end

@implementation SAboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _thisNum.text = [NSString stringWithFormat:@"当前版本:v%@",app_Version];
    
    SArticleAboutUs * infor = [[SArticleAboutUs alloc] init];
    [infor sArticleAboutUsSuccess:^(NSString *code, NSString *message, id data) {
        SArticleAboutUs * infor = (SArticleAboutUs *)data;
        _copyright.text = infor.data.copyright;
        _company_name.text = infor.data.company_name;
    } andFailure:^(NSError *error) {
    }];
    
    
    _thisLogo.layer.masksToBounds = YES;
    _thisLogo.layer.cornerRadius = 10;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"关于我们";
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
