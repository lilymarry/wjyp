//
//  Sintegral_sub.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "Sintegral_sub.h"
#import "SUserChangeIntegral.h"
#import "SUserAutoChange.h"

@interface Sintegral_sub () <UITextFieldDelegate>
{
    NSString * interNum;
}
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (strong, nonatomic) IBOutlet UILabel *oneTitle;
@property (strong, nonatomic) IBOutlet UIButton *oneTitleBtn;
@property (strong, nonatomic) IBOutlet UILabel *twoTitle;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *thisDes;
@end

@implementation Sintegral_sub

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可兑换积分%zd",[_my_integral integerValue]]];
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:MyBlue range:NSMakeRange(6 + [NSString stringWithFormat:@"%zd",[_my_integral integerValue]].length, 4)];
    _oneTitle.attributedText = AttributedStr;

    
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    
    [_oneTitleBtn addTarget:self action:@selector(oneTitleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    interNum = @"";
    _numTF.delegate = self;
    [self showModel];
    [_numTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_numTF addTarget:self action:@selector(textFieldDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
}
- (void)showModel {
    SUserAutoChange *  infor = [[SUserAutoChange alloc] init];
    infor.integral = interNum;
    [infor sUserAutoChangeSuccess:^(NSString *code, NSString *message, id data) {
        SUserAutoChange * infor = (SUserAutoChange *)data;
        NSMutableAttributedString * AttributedStr_sub = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"积分转余额，手续费率%@",infor.data.integral_percentage]];
        [AttributedStr_sub addAttribute:NSForegroundColorAttributeName value:MyBlue range:NSMakeRange(10, infor.data.integral_percentage.length)];
        _twoTitle.attributedText = AttributedStr_sub;
        _thisDes.text = infor.data.desc;

    } andFailure:^(NSError *error) {
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"积分转余额";
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
- (void)oneTitleBtnClick {
    _numTF.text = [NSString stringWithFormat:@"%zd",[_my_integral integerValue]];
}
- (void)submitBtnClick {
    _submitBtn.userInteractionEnabled = NO;
    SUserChangeIntegral * change = [[SUserChangeIntegral alloc] init];
    change.integral = _numTF.text;
    [MBProgressHUD showMessage:nil toView:self.view];
    [change sUserChangeIntegralSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
            _submitBtn.userInteractionEnabled = YES;
        }
    } andFailure:^(NSError *error) {
        _submitBtn.userInteractionEnabled = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)textFieldDidEnd:(UITextField *)field {
    if ([field.text integerValue] % 10 != 0) {
        //不是10倍数
        [MBProgressHUD showError:@"输入的积分不是10的倍数，请重新输入。" toView:self.view];
        field.text = @"";
        [self textFieldChanged:field];
    }
}
- (void)textFieldChanged:(UITextField *)field {
    field.text = [field.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    field.text = [NSString stringWithFormat:@"%.f", floorf([field.text intValue])];
    if ([field.text integerValue] > [_my_integral integerValue]) {
        _numTF.text = [NSString stringWithFormat:@"%ld",[_my_integral integerValue]];
    } else {
        _numTF.text = field.text;
    }
    interNum = _numTF.text;
    [self showModel];
}
@end
