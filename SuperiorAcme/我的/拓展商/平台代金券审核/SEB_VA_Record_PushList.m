//
//  SEB_VA_Record_PushList.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VA_Record_PushList.h"
#import "SNPageView.h"
#import "SEB_VoucherMine_Content.h"
#import "SEB_VA_RP_infor.h"

@interface SEB_VA_Record_PushList ()
{
    SEB_VoucherMine_Content * thisContent;
}
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
@end

@implementation SEB_VA_Record_PushList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    _submitbtn.layer.masksToBounds = YES;
    _submitbtn.layer.cornerRadius = 3;
    
    
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5 - 60) p_style:PageViewStyleLine];
    pageView.subViews = @[[SEB_VoucherMine_Content class],[SEB_VoucherMine_Content class],[SEB_VoucherMine_Content class]];
    pageView.titles = @[@"黄券",@"蓝券",@"已使用"];
    pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/3;
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SEB_VA_Record_PushList * gSelf = self;
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
        
        NSLog(@"%@",[subView class]);
        thisContent = subView;
        if (index == 0) {
            [thisContent show:@"1"];
        }
        if (index == 1) {
            [thisContent show:@"2"];
        }
        if (index == 2) {
            [thisContent show:@"3"];
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"发放代金券";
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
- (IBAction)submitBtn:(UIButton *)sender {
    SEB_VA_RP_infor * infor = [[SEB_VA_RP_infor alloc] init];
    [self.navigationController pushViewController:infor animated:YES];
}

@end
