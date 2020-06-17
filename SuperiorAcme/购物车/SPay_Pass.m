 //
//  SPay_Pass.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SPay_Pass.h"
#import "SUserVerificationPayPwd.h"
#import "SModifyLoginPassword.h"

@interface SPay_Pass ()
@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *passTF;

@end

@implementation SPay_Pass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 5;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    
}

- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)submitBtn:(UIButton *)sender {
    
    SUserVerificationPayPwd * pay = [[SUserVerificationPayPwd alloc] init];
    pay.PayPwd = _passTF.text;
    [MBProgressHUD showMessage:nil toView:self.view];
    [pay sUserVerificationPayPwdSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.SPay_Pass_back) {
                        self.SPay_Pass_back();
                    }
                }];
            });
        } else {
            SUserVerificationPayPwd * pay = (SUserVerificationPayPwd *)data;
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([pay.data.status isEqualToString:@"0"]) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.SPay_Pass_set) {
                            self.SPay_Pass_set();
                        }
                    }];
                }
            });
            
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}

@end
