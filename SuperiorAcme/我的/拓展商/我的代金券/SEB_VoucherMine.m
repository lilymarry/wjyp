//
//  SEB_VoucherMine.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50

#import "SEB_VoucherMine.h"
#import "SNPageView.h"
#import "SEB_VoucherMine_Content.h"

@interface SEB_VoucherMine () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mScroll;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIView *mScroll_view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mScoll_viewHHH;
@end

@implementation SEB_VoucherMine

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 35;
    
    _mScroll.delegate = self;
    _mScoll_viewHHH.constant = ScreenH + ScreenW/125*71 + 10 - 64;
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, ScreenW/125*71 + 10, ScreenW, ScreenH - 64) p_style:PageViewStyleLine];
    pageView.subViews = @[[SEB_VoucherMine_Content class],[SEB_VoucherMine_Content class]];
    pageView.titles = @[@"黄券",@"蓝券"];
    pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/2;
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SEB_VoucherMine * gSelf = self;
    [pageView showInView:_mScroll_view action:^(id subView, UIButton *btn, NSInteger index) {
        
        //        NSLog(@"%@",[subView class]);
//        thisContent = subView;
//        thisContent.SEB_VoucherAuditView_Infor = ^{
//            SEB_VAInfor * infor = [[SEB_VAInfor alloc] init];
//            [gSelf.navigationController pushViewController:infor animated:YES];
//        };
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    adjustsScrollViewInsets_NO(_mScroll, self);
    [self scrollViewDidScroll:_mScroll];
    
    self.title = @"我的代金券";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        //        home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(300-64)&&contentOffsety>=0) {
        _mScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=300-64){
        _mScroll.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
