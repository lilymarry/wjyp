//
//  SAM_MineApply.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAM_MineApply.h"
#import "SNPageView.h"
#import "SEB_VoucherAuditView.h"
#import "SEV_window.h"
#import "SAM_MA_infor.h"

@interface SAM_MineApply ()
{
    SEB_VoucherAuditView * thisContent;
}
@end

@implementation SAM_MineApply

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
    pageView.subViews = @[[SEB_VoucherAuditView class],[SEB_VoucherAuditView class],[SEB_VoucherAuditView class],[SEB_VoucherAuditView class]];
    self.title = @"推荐商家审核";
    pageView.titles = @[@"全部",@"待审核",@"审核中",@"已通过",@"未通过"];
    pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/4;
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SAM_MineApply * gSelf = self;
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
        
        //        NSLog(@"%@",[subView class]);
        thisContent = subView;
        [thisContent showModel:@"2"];
        
        thisContent.SEB_VoucherAuditView_Infor = ^{
            SAM_MA_infor * infor = [[SAM_MA_infor alloc] init];
            [gSelf.navigationController pushViewController:infor animated:YES];
        };
        thisContent.SEB_VoucherAuditView_oneBtn = ^(UIButton *btn) {
            if ([btn.titleLabel.text isEqualToString:@"拒绝通过"]) {
                SEV_window * win = [[SEV_window alloc] init];
                win.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                win.modalPresentationStyle = UIModalPresentationOverFullScreen;
                [gSelf presentViewController:win animated:YES completion:nil];
                win.twoView_topHHH.constant = 10;
                win.status.text = @"拒绝通过";
                win.twoViewTF.text = @"输入拒绝理由";
            }
        };
        thisContent.SEB_VoucherAuditView_twoBtn = ^(UIButton *btn) {
            if ([btn.titleLabel.text isEqualToString:@"通过审核"]) {
                SEV_window * win = [[SEV_window alloc] init];
                win.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                win.modalPresentationStyle = UIModalPresentationOverFullScreen;
                [gSelf presentViewController:win animated:YES completion:nil];
            }
        };
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    
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
