//
//  SDA_ADD.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SDA_ADD.h"
#import "SAM_Mine.h"

@interface SDA_ADD ()
{
    
}
@property (weak, nonatomic) IBOutlet UIView *percentage_one;
@property (weak, nonatomic) IBOutlet UIView *percentage_two;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SDA_ADD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _percentage_one.layer.masksToBounds = YES;
    _percentage_one.layer.cornerRadius = 2;
    _percentage_one.layer.borderWidth = 0.5;
    _percentage_one.layer.borderColor = WordColor_30.CGColor;
    
    _percentage_two.layer.masksToBounds = YES;
    _percentage_two.layer.cornerRadius = 2;
    _percentage_two.layer.borderWidth = 0.5;
    _percentage_two.layer.borderColor = WordColor_30.CGColor;
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"拓展商添加";
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
- (IBAction)merBtn:(UIButton *)sender {
    SAM_Mine * mine = [[SAM_Mine alloc] init];
    mine.choice_isno = YES;
    [self.navigationController pushViewController:mine animated:YES];
}
- (IBAction)submitBtn:(UIButton *)sender {
}
@end
