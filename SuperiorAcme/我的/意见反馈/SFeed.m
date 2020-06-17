//
//  SFeed.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SFeed.h"
#import "SOnlineShop_ClassView.h"
#import "SFeed_NewContent.h"
#import "SNPageView.h"
#import "SArticleFeedbackType.h"
#import "SArticleFeedback.h"

@interface SFeed () <UITextViewDelegate>
{
    SFeed_NewContent * content;
}
@end

@implementation SFeed

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SArticleFeedbackType * infor = [[SArticleFeedbackType alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sArticleFeedbackTypeSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SArticleFeedbackType * infor = (SArticleFeedbackType *)data;
        
        //类型name
        NSMutableArray * typeArr_name = [[NSMutableArray alloc] init];
        NSMutableArray * typeArr_id = [[NSMutableArray alloc] init];
        for (SArticleFeedbackType * list_type  in infor.data.feedback_type) {
            [typeArr_name addObject:list_type.f_type_name];
            [typeArr_id addObject:list_type.f_type_id];
        }
        //类型class
        NSMutableArray * typeArr_class = [[NSMutableArray alloc] init];
        for (int i = 0; i < typeArr_name.count; i++) {
            [typeArr_class addObject:[SFeed_NewContent class]];
        }
        
        SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
        pageView.subViews = typeArr_class;
        pageView.titles = typeArr_name;
        pageView.titleWidth = 100;
        pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
        pageView.sliderColor = WordColor;
        pageView.defaultSelectedIndex = 0;
        pageView.topTitleViewColor = [UIColor whiteColor];
        pageView.goundNormalColor = [UIColor whiteColor];
        __block SFeed * gSelf = self;
        [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
            if (index > 1) {
                [pageView.topScrollView setContentOffset:CGPointMake((index - 1) * 100 - ScreenW/2/2 + 50, 0) animated:YES];
            }
            content = subView;
            [content showModel:infor.data.real_name andUser_id:infor.data.user_id];
            content.SFeed_NewContent_Back = ^(NSString *contentTV) {
                
                SArticleFeedback * model = [[SArticleFeedback alloc] init];
                model.f_type_id = typeArr_id[index];
                if ([contentTV isEqualToString:@"请描述您的问题"]) {
                    model.content = @"";
                } else {
                    model.content = contentTV;
                }
                [MBProgressHUD showMessage:nil toView:gSelf.view];
                [model sArticleFeedbackSuccess:^(NSString *code, NSString *message) {
                    [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                    if ([code isEqualToString:@"1"]) {
                        [MBProgressHUD showSuccess:message toView:gSelf.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [gSelf.navigationController popViewControllerAnimated:YES];
                        });
                    } else {
                        [MBProgressHUD showError:message toView:gSelf.view];
                    }
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                }];
            };
        }];
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"意见反馈";
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
