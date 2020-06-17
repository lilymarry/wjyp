//
//  CollectionAccountVC.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CollectionAccountVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"//微信SDK头文件
#import "SModifyLoginPassword.h" //设置支付密码
#import "SPay_Pass.h" //验证支付密码
#import "SRecharge.h"

@interface CollectionAccountVC ()
@property (weak, nonatomic) IBOutlet UIImageView *platformSelectImage;
@property (weak, nonatomic) IBOutlet UILabel *platformAccountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wxSelectImage;
@property (weak, nonatomic) IBOutlet UIButton *wxVerifyButton;
@property (weak, nonatomic) IBOutlet UILabel *wxAccountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alipaySelectImage;
@property (weak, nonatomic) IBOutlet UIButton *alipayVerifyButton;
@property (weak, nonatomic) IBOutlet UITextField *alipayAccountTextField;

@end

@implementation CollectionAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
/// 绑定账户 tag 100:微信 101:支付宝
- (IBAction)bindAccount:(id)sender {
    if (_isShowAlert) {
        [self notSufficientFundsTips];
        return;
    }
    
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 100) {
        //绑定微信
        [self bindWXAccount];
    } else {
        //绑定支付宝
        [self bindAlipayAccount];
    }
}

-(void)notSufficientFundsTips{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                    message:@"您的会员账户余额不足2元,请前去充值！"
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action_sure = [UIAlertAction actionWithTitle:@"去充值"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self.navigationController pushViewController:[SRecharge new] animated:YES];
                                                        }];
    UIAlertAction *action_cancle = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                        }];
    [alertC addAction:action_sure];
    [alertC addAction:action_cancle];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (IBAction)selectDefault:(UITapGestureRecognizer *)sender {
    UIImageView * imageView = (UIImageView *)sender.view;
    NSInteger selectType = imageView.tag;
    [self accountBind:@"" andAccountStr:@"" andWxpay_name:@"" andPay_money:@"" andDefault_account:[NSString stringWithFormat:@"%ld", (long)selectType]];
}
/// 绑定支付宝
- (void)bindAlipayAccount {
    if ([_alipayAccountTextField.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入支付宝账户!" toView:self.view];
    } else {
        // 验证用户支付密码
        [self verifyUser:@"ali" andAccountStr:_alipayAccountTextField.text];
    }
}
/// 绑定微信
- (void)bindWXAccount {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             self.wxAccountLabel.text = user.nickname;
             // 验证用户支付密码
             [self verifyUser:@"wx" andAccountStr:user.uid];
         }
         else
         {
             [MBProgressHUD showError:[error localizedDescription] toView:self.view];
         }
     }];
}

/// 验证用户支付密码
- (void)verifyUser:(NSString *)accountType andAccountStr:(NSString *)accountStr {
    SPay_Pass * pass = [[SPay_Pass alloc] init];
    pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController presentViewController:pass animated:YES completion:nil];
    pass.SPay_Pass_back = ^{
        // 提交绑定信息
        [self submitAccountInfo:accountType andAccountStr:accountStr];
    };
    pass.SPay_Pass_set = ^{
        SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
        logPass.type = YES;
        logPass.set_type = NO;
        [self.navigationController pushViewController:logPass animated:YES];
    };
}

/**
 提交绑定信息

 @param accountType 账户类型
 @param accountStr 账户信息
 */
- (void)submitAccountInfo:(NSString *)accountType andAccountStr:(NSString *)accountStr {
    [MBProgressHUD showMessage:nil toView:self.view];
    [HttpManager postWithUrl:@"User/pay_money_bind" andParameters:@{@"pay_type" : accountType, @"account" : accountStr} andSuccess:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary * dic =(NSDictionary *)Json;
        NSString * mes = dic[@"message"];
        if ([dic[@"code"] isEqualToString:@"1"]) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"" message:mes preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入收到的金额";
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction * affirmAction = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString * pay_name = @"";
                if ([accountType isEqualToString:@"wx"]) {
                    // 微信
                    pay_name = _wxAccountLabel.text;
                }
                [self accountBind:accountType andAccountStr:accountStr andWxpay_name:pay_name andPay_money:alertController.textFields.lastObject.text andDefault_account:@""];
            }];
            [alertController addAction:affirmAction];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            [MBProgressHUD showError:mes toView:self.view];
        }
    } andFail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


/**
 收款账户绑定 和 设置默认收款账户

 @param accountType 该参数是表明提交是微信还是支付宝的参数，wx:设置微信，ali:设置支付宝
 @param accountStr      绑定账户，支付宝格式手机号或者邮箱，微信的是openid
 @param wxpay_name 微信昵称，只有在pay_type=wx的时候这个参数是必填
 @param pay_money 该参数是 输入的三方账户到款金额
 @param default_account      这个参数跟下面的参数不混，传这个参数只是走设置默认收款账户，该接口请求时间间隔5分钟。 默认账户 1无界会员 2微信账户 3支付宝账户
 */
- (void)accountBind:(NSString *)accountType andAccountStr:(NSString *)accountStr andWxpay_name:(NSString *)wxpay_name andPay_money:(NSString *)pay_money andDefault_account:(NSString *)default_account {
    [MBProgressHUD showMessage:nil toView:self.view];
    [HttpManager postWithUrl:@"User/pay_account_bind" andParameters:@{@"pay_type" : accountType, @"account" : accountStr, @"wxpay_name" : wxpay_name, @"pay_money" : pay_money, @"default_account" : default_account , @"id" : _shopId} andSuccess:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary * dic =(NSDictionary *)Json;
        NSString * mes = dic[@"message"];
        if ([dic[@"code"] isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:[self  exchangStr:mes] toView:self.view];
            //获取最新数据
            [self getData];
        } else {
            [MBProgressHUD showError:[self  exchangStr:mes]  toView:self.view];
        }
    } andFail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(NSString *)exchangStr:(NSString *)str
{
   
    NSString *newStr=[str stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    NSString *newNewStr=[newStr stringByReplacingOccurrencesOfString:@"" withString:@"<br>"];
    return newNewStr;
}
/// 获取数据
- (void)getData {
    [MBProgressHUD showMessage:nil toView:self.view];
    [HttpManager postWithUrl:@"User/payee_bind" andParameters:@{@"id":_shopId} andSuccess:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary * dic =(NSDictionary *)Json;
        if ([dic[@"code"] isEqualToString:@"1"]) {
            
            NSDictionary * data = dic[@"data"];
            self.platformAccountLabel.text = data[@"phone"];
            
            if ([data[@"is_pay_password"] isEqualToNumber:@0]) {
                //未设置支付密码 提示设置支付密码
                [MBProgressHUD showError:@"请先设置支付密码" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                    logPass.type = YES;
                    logPass.set_type = NO;
                    [self.navigationController pushViewController:logPass animated:YES];
                });
            }
            
            if (![data[@"wxpay_accounts"] isEqualToString:@""]) {
                self.wxSelectImage.hidden = NO;
                self.wxVerifyButton.hidden = YES;
                self.wxAccountLabel.text = data[@"wxpay_name"];
            }
            if (![data[@"alipay_accounts"] isEqualToString:@""]) {
                self.alipaySelectImage.hidden = NO;
                self.alipayVerifyButton.hidden = YES;
                self.alipayAccountTextField.text = data[@"alipay_accounts"];
                self.alipayAccountTextField.enabled = NO;
            }
            
            NSInteger accountType = [data[@"default_account"] integerValue];
            switch (accountType) {
                case 1:
                    //无界会员
                    self.platformSelectImage.highlighted = YES;
                    self.wxSelectImage.highlighted = NO;
                    self.alipaySelectImage.highlighted = NO;
                    break;
                case 2:
                    //微信账户
                    self.wxSelectImage.highlighted = YES;
                    self.platformSelectImage.highlighted = NO;
                    self.alipaySelectImage.highlighted = NO;
                    break;
                case 3:
                    //支付宝账户
                    self.alipaySelectImage.highlighted = YES;
                    self.platformSelectImage.highlighted = NO;
                    self.wxSelectImage.highlighted = NO;
                    break;
            }
        }
    } andFail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [self createNav];
    //获取数据
    [self getData];
}
- (void)createNav {
    self.title = @"三方收款账户";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
