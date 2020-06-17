//
//  SMaterielApply.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMaterielApply.h"
#import "SNPageView.h"
#import "SEB_VoucherAuditView.h"
#import "SMA_infor.h"
#import "SMA_inforPhoto.h"

@interface SMaterielApply ()
{
    SEB_VoucherAuditView * thisContent;
}

@property (weak, nonatomic) IBOutlet SNPageView *pageView;

@end

@implementation SMaterielApply

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
    pageView.subViews = @[[SEB_VoucherAuditView class],[SEB_VoucherAuditView class],[SEB_VoucherAuditView class],[SEB_VoucherAuditView class],[SEB_VoucherAuditView class]];
    pageView.titles = @[@"全部",@"审核中",@"待收货",@"已完成",@"未通过"];

    _pageView = pageView;
    
    pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/5;
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SMaterielApply * gSelf = self;
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
        
        //        NSLog(@"%@",[subView class]);
        thisContent = subView;
        [thisContent showModel_sub:YES];
        
        thisContent.SEB_VoucherAuditView_Infor = ^{
            SMA_infor * infor = [[SMA_infor alloc] init];
            [gSelf.navigationController pushViewController:infor animated:YES];
        };
        thisContent.SEB_VoucherAuditView_twoBtn = ^(UIButton *btn) {
            SMA_inforPhoto * photo = [[SMA_inforPhoto alloc] init];
            [gSelf.navigationController pushViewController:photo animated:YES];
        };
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_isno == NO) {
        self.title = @"平台物料审核";
    } else {
        self.title = @"物料审核";
    }
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
