//
//  SEB_VA_Record_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VA_Record_infor.h"
#import "SNPageView.h"
#import "SEB_VoucherMine_Content.h"
#import "SEB_VM_Record.h"

@interface SEB_VA_Record_infor ()
{
    SEB_VoucherMine_Content * thisContent;
}
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIView *mScroll_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mScoll_viewHHH;
@end

@implementation SEB_VA_Record_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 35;
    
    _mScoll_viewHHH.constant = 200 + ScreenH - 64 - 10;
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 200, ScreenW, ScreenH - 64 - 10) p_style:PageViewStyleLine];
    pageView.subViews = @[[SEB_VoucherMine_Content class],[SEB_VoucherMine_Content class],[SEB_VoucherMine_Content class]];
    pageView.titles = @[@"黄券",@"蓝券",@"已使用"];
    pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/3;
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SEB_VA_Record_infor * gSelf = self;
    [pageView showInView:_mScroll_view action:^(id subView, UIButton *btn, NSInteger index) {
        
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
    
    self.title = @"CINCO的代金券";
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"发放记录" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    SEB_VM_Record * record = [[SEB_VM_Record alloc] init];
    [self.navigationController pushViewController:record animated:YES];
}

@end
