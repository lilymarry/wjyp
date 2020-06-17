//
//  SRecharge.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRecharge.h"
#import "SRechargeBank.h"
#import "TimeDatePick.h"
#import "SUserBalanceUpMoney.h"
#import "SUserBalanceUnderMoney.h"
//三方多图
#import "UIImage+ZLPhotoLib.h"
#import "ZLPhoto.h"

#import "SPayGetAlipayParam.h"
#import "SNPayManager.h"
#import "SPayFindPayResult.h"
#import "SPayGetHjsp.h"
#import "SShopCouponUseCan.h"//余额明细
#import "SMemberOrder.h"
#import "SUserUserInfo.h"
#import "SPersonalData.h"
#import "SRealNameAuth.h"

@interface SRecharge () <ZLPhotoPickerBrowserViewControllerDelegate, UITextViewDelegate>
{
    UIView * red_line;
    NSMutableArray * hourArr;
    BOOL online_isno;//NO 线上充值 YES 线下充值
    NSString * pay_type;//1微信 2支付宝
    
    NSString * model_com_card_id;//平台
    NSString * model_bank_card_id;//汇款人
    NSString * model_act_time;
    UIImage * pic;
    
    UIButton *rigthBtn;
}
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *top_oneBtn;//线上充值
@property (strong, nonatomic) IBOutlet UIButton *top_twoBtn;//线下充值
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;//微信支付
@property (weak, nonatomic) IBOutlet UIView *weixinView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinView_HHH;
@property (strong, nonatomic) IBOutlet UIImageView *oneBtn_RImage;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;//支付宝支付
@property (strong, nonatomic) IBOutlet UIImageView *twoBtn_RImage;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn_1;//确认付款
@property (strong, nonatomic) IBOutlet UIScrollView *mScroll;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn_2;//确认
@property (strong, nonatomic) IBOutlet UIButton *choiceBankBtn;//选择汇款银行卡号
@property (strong, nonatomic) IBOutlet UIButton *choiceTimeBtn;//选择汇款时间
@property (strong, nonatomic) IBOutlet UITextField *timeTF;

@property (strong, nonatomic) IBOutlet UITextField *online_payMoneyTF;

@property (strong, nonatomic) IBOutlet UITextField *bank_card_idTF;
@property (weak, nonatomic) IBOutlet UITextField *com_card_idTF;
@property (strong, nonatomic) IBOutlet UITextField *moneyTF;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextView *descTV;
@property (strong, nonatomic) IBOutlet UITextField *pay_passwordTF;
@property (strong, nonatomic) IBOutlet UIImageView *choiceImage;
@property (strong, nonatomic) IBOutlet UIButton *choiceImageBtn;
@end

@implementation SRecharge

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
    red_line = [[UIView alloc] initWithFrame:CGRectMake(ScreenW/2 - 110, 48, 100, 2)];
    [_topView addSubview:red_line];
    red_line.backgroundColor = [UIColor redColor];
    //默认线上充值
    [_top_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _mScroll.hidden = YES;
    _submitBtn_2.hidden = YES;
    //线上充值
    [_top_oneBtn addTarget:self action:@selector(top_oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //线下充值
    [_top_twoBtn addTarget:self action:@selector(top_twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //微信支付
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //支付宝支付
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //默认微信支付
    _oneBtn_RImage.image = [UIImage imageNamed:@"R选中"];
    pay_type = @"1";
    
    _submitBtn_1.layer.masksToBounds = YES;
    _submitBtn_1.layer.cornerRadius = 3;
    [_submitBtn_1 addTarget:self action:@selector(submitBtn_1Click) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn_2.layer.masksToBounds = YES;
    _submitBtn_2.layer.cornerRadius = 3;
    [_submitBtn_2 addTarget:self action:@selector(submitBtn_2Click) forControlEvents:UIControlEventTouchUpInside];
    
    //汇款银行卡号
    [_choiceBankBtn addTarget:self action:@selector(choiceBankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //汇款时间
    [_choiceTimeBtn addTarget:self action:@selector(choiceTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    hourArr = [[NSMutableArray alloc] init];
    [hourArr addObject:@"0"];
    [hourArr addObject:@"1"];
    [hourArr addObject:@"2"];
    [hourArr addObject:@"3"];
    [hourArr addObject:@"4"];
    [hourArr addObject:@"5"];
    [hourArr addObject:@"6"];
    [hourArr addObject:@"7"];
    [hourArr addObject:@"8"];
    [hourArr addObject:@"9"];
    [hourArr addObject:@"10"];
    [hourArr addObject:@"11"];
    [hourArr addObject:@"12"];
    [hourArr addObject:@"13"];
    [hourArr addObject:@"14"];
    [hourArr addObject:@"15"];
    [hourArr addObject:@"16"];
    [hourArr addObject:@"17"];
    [hourArr addObject:@"18"];
    [hourArr addObject:@"19"];
    [hourArr addObject:@"20"];
    [hourArr addObject:@"21"];
    [hourArr addObject:@"22"];
    [hourArr addObject:@"23"];
    
    model_bank_card_id = @"";
    model_act_time = @"";
    
    [_choiceImageBtn addTarget:self action:@selector(choiceImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _descTV.delegate = self;
    
    if (![WXApi isWXAppInstalled]) {
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
    }
    
    if (_money != nil) {
        _online_payMoneyTF.text = _money;
        _online_payMoneyTF.userInteractionEnabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mScroll, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"余额充值";
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
    
    /* 暂时隐藏明细按钮及功能
    rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"明细" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
     */
    
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    SShopCouponUseCan * useCan = [[SShopCouponUseCan alloc] init];
    if (online_isno == NO) {
        useCan.type = @"3";
    } else {
        useCan.type = @"5";
    }
    [self.navigationController pushViewController:useCan animated:YES];
}
#pragma mark - 线上充值
- (void)top_oneBtnClick {
   
    red_line.frame = CGRectMake(ScreenW/2 - 110, 48, 100, 2);
    [_top_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_top_twoBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    _mScroll.hidden = YES;
    _submitBtn_2.hidden = YES;
    online_isno = NO;
//    rigthBtn.hidden = YES;
}
-(void)changeButtonStatus{
    _submitBtn_1.enabled =YES;
}
-(void)changeButtonStatus1{
    _submitBtn_2.enabled =YES;
}
#pragma mark - 线下充值
- (void)top_twoBtnClick {
    red_line.frame = CGRectMake(ScreenW/2 + 10, 48, 100, 2);
    [_top_oneBtn setTitleColor:WordColor_sub forState:UIControlStateNormal];
    [_top_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _mScroll.hidden = NO;
    _submitBtn_2.hidden = NO;
    online_isno = YES;
//    rigthBtn.hidden = NO;
}
#pragma mark - 微信支付
- (void)oneBtnClick {
    _oneBtn_RImage.image = [UIImage imageNamed:@"R选中"];
    _twoBtn_RImage.image = [UIImage imageNamed:@"R默认"];
    pay_type = @"1";
}
#pragma mark - 支付宝支付
- (void)twoBtnClick {
    _oneBtn_RImage.image = [UIImage imageNamed:@"R默认"];
    _twoBtn_RImage.image = [UIImage imageNamed:@"R选中"];
    pay_type = @"2";
}
#pragma mark - 线上充值提交
- (void)submitBtn_1Click {
    _submitBtn_1.enabled=NO;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:1.5f];//防止重复点击
    if ([pay_type isEqualToString:@"1"]) {
        //微信
        SPayGetHjsp * tine = [[SPayGetHjsp alloc] init];
        tine.totalPrice = _online_payMoneyTF.text;
        tine.order_id = _order_id == nil ? @"" : _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [tine sPayGetHjspSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if ([code isEqualToString:@"1"]) {
                SPayGetHjsp * tine = (SPayGetHjsp *)data;
                SNPayManager * manager = [SNPayManager sharePayManager];
                manager.wxPartnerId = tine.data.mch_id;//商户号
                manager.wxPrepayId = tine.data.prepay_id;//预支付id
                manager.wxNonceStr = tine.data.nonce_str;//随机字符串
                manager.wxTimeStamp = tine.data.time_stamp;//时间戳
                manager.wxSign = tine.data.sign;//签名
                [manager sn_openTheWechatWithServicePay:^(NSError *error) {
                    if (error) {
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            SMemberOrder * list = [[SMemberOrder alloc] init];
                            list.coming = YES;
                            list.type = @"充值";
                            [self.navigationController pushViewController:list animated:YES];
                        });
                    } else {
                        //支付结果查询
                        [self payShow:tine.data.order_id];
                    }
                }];
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SMemberOrder * list = [[SMemberOrder alloc] init];
                    list.coming = YES;
                    list.type = @"充值";
                    [self.navigationController pushViewController:list animated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"充值";
                [self.navigationController pushViewController:list animated:YES];
            });
        }];
    } else {
        SUserBalanceUpMoney * upMoney = [[SUserBalanceUpMoney alloc] init];
        upMoney.money = _online_payMoneyTF.text;
        upMoney.pay_type = pay_type;
        upMoney.note = @"";
        upMoney.order_id = _order_id == nil ? @"" : _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [upMoney sUserBalanceUpMoneySuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SUserBalanceUpMoney * upMoney = (SUserBalanceUpMoney *)data;
                
                //支付宝
                SPayGetAlipayParam * getPay = [[SPayGetAlipayParam alloc] init];
                getPay.order_id = upMoney.data.order_id;
                getPay.discount_type = @"0";
                getPay.type = @"1";
                [MBProgressHUD showMessage:nil toView:self.view];
                [getPay sPayGetAlipayParamSuccess:^(NSString *code, NSString *message, id data) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    SPayGetAlipayParam * getPay = (SPayGetAlipayParam *)data;
                    [[SNPayManager sharePayManager] sn_openTheAlipayOrderString:getPay.data.pay_string WithServicePay:^(NSError *error) {
                        if (error) {
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                SMemberOrder * list = [[SMemberOrder alloc] init];
                                list.coming = YES;
                                list.type = @"充值";
                                [self.navigationController pushViewController:list animated:YES];
                            });
                        } else {
                            //支付结果查询
                            [self payShow:upMoney.data.order_id];
                        }
                    }];
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:self.view];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        SMemberOrder * list = [[SMemberOrder alloc] init];
                        list.coming = YES;
                        list.type = @"充值";
                        [self.navigationController pushViewController:list animated:YES];
                    });
                }];
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SMemberOrder * list = [[SMemberOrder alloc] init];
                    list.coming = YES;
                    list.type = @"充值";
                    [self.navigationController pushViewController:list animated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"充值";
                [self.navigationController pushViewController:list animated:YES];
            });
        }];
    }
    
}
#pragma mark - 支付结果查询
- (void)payShow:(NSString *)order_id {
    SPayFindPayResult * result = [[SPayFindPayResult alloc] init];
    result.order_id = order_id;
    result.type = @"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [result sPayFindPayResultSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SPayFindPayResult * result = (SPayFindPayResult *)data;
        NSLog(@"result.data.status:%@",result.data.status);
        if ([result.data.status isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"支付成功" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"充值";
                [self.navigationController pushViewController:list animated:YES];
            });
        } else {
            [MBProgressHUD showError:@"支付失败" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"充值";
                [self.navigationController pushViewController:list animated:YES];
            });
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            SMemberOrder * list = [[SMemberOrder alloc] init];
            list.coming = YES;
            list.type = @"充值";
            [self.navigationController pushViewController:list animated:YES];
        });
    }];
    
}
#pragma mark - 选择平台银行卡号
- (IBAction)choiceComBankBtn:(UIButton *)sender {
    SRechargeBank * bank = [[SRechargeBank alloc] init];
    bank.type = YES;
    [self.navigationController pushViewController:bank animated:YES];
    bank.SRechargeBank_choice = ^(NSString *bank_card_id, NSString *bank_card_code) {
        model_com_card_id = bank_card_id;
        _com_card_idTF.text = bank_card_code;
    };
}
#pragma mark - 选择汇款银行卡号
- (void)choiceBankBtnClick {
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        SUserUserInfo * userInfo = (SUserUserInfo *)data;
        if ([userInfo.data.personal_data_status integerValue] == 0) {
            [MBProgressHUD showError:@"请先完善个人资料" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SPersonalData * pd = [[SPersonalData alloc] init];
                [self.navigationController pushViewController:pd animated:YES];
            });
        } else {
            if ([userInfo.data.auth_status integerValue] == 1){
                [MBProgressHUD showError:@"实名认证中,请耐心等待..." toView:self.view];
            }else if ([userInfo.data.auth_status integerValue] != 2) {
                [MBProgressHUD showError:@"请先完善个人认证" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SRealNameAuth * auth = [[SRealNameAuth alloc] init];
                    [self.navigationController pushViewController:auth animated:YES];
                });
            } else {
                SRechargeBank * bank = [[SRechargeBank alloc] init];
                [self.navigationController pushViewController:bank animated:YES];
                bank.SRechargeBank_choice = ^(NSString *bank_card_id, NSString *bank_card_code) {
                    model_bank_card_id = bank_card_id;
                    _bank_card_idTF.text = bank_card_code;
                };
            }
        }
    } andFailure:^(NSError *error) {
    }];
}
#pragma mark - 选择汇款时间
- (void)choiceTimeBtnClick {
    //预定
    
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    
    TimeDatePick * pick = [[TimeDatePick alloc] init];
    pick.type = @"1";
    pick.thisHour = hourArr;
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];
    [pick hiddenForever];

    pick.TimeDatePickBack = ^() {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    pick.TimeDatePickSubmit_YMD = ^(NSString * year, NSString * month, NSString * day, NSString * hour, NSString * minute) {
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
        
//        NSLog(@"Now:%@",[NSString stringWithFormat:@"%@.%@.%@ %@:%@",year,month,day,hour,minute]);
        _timeTF.text = [NSString stringWithFormat:@"%@.%@.%@ %@:%@",year,month,day,hour,minute];
        
        NSString* timeStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",year,month,day,hour,minute];//2011-01-26 17:40:50
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        NSLog(@"timeSp:%@",timeSp); //时间戳的值
        model_act_time = timeSp;
        
    };
}
- (void)choiceImageBtnClick {
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1 ;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.photoStatus = PickerPhotoStatusPhotos;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.isShowCamera = YES;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        NSLog(@"sss:%@",status.mutableCopy);
        
        for (int i = 0; i < status.count; i++) {
            id assets = status[i];
            if ([assets isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets * ddd = (ZLPhotoAssets *)assets;
                pic = ddd.originImage;
                _choiceImage.image = ddd.originImage;
            } else {
                ZLCamera * ddd = (ZLCamera *)assets;
                pic = ddd.photoImage;
                _choiceImage.image = ddd.photoImage;
            }
        }
    };
    [pickerVc showPickerVc:self];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([_descTV.text isEqualToString:@"请填写汇款说明"]) {
        _descTV.text = @"";
        _descTV.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([_descTV.text isEqualToString:@""]) {
        _descTV.text = @"请填写汇款说明";
        _descTV.textColor = WordColor_30;
    }
    return YES;
}
#pragma mark - 线下充值提交
- (void)submitBtn_2Click {
    _submitBtn_2.enabled=NO;
    [self performSelector:@selector(changeButtonStatus1)withObject:nil afterDelay:1.5f];//防止重复点击
    SUserBalanceUnderMoney * underMoney = [[SUserBalanceUnderMoney alloc] init];
    if ([_com_card_idTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择平台银行卡号" toView:self.view];
        return;
    }
    underMoney.platform_account_id = model_com_card_id;
    if ([_bank_card_idTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择汇款银行卡号" toView:self.view];
        return;
    }
    underMoney.bank_card_id = model_bank_card_id;
    if ([_timeTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择汇款时间" toView:self.view];
        return;
    }
    underMoney.act_time = model_act_time;
    if ([_moneyTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入汇款金额" toView:self.view];
        return;
    }
    underMoney.money = _moneyTF.text;
    if ([_nameTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入汇款人姓名" toView:self.view];
        return;
    }
    underMoney.name = _nameTF.text;
    if (pic == nil) {
        [MBProgressHUD showError:@"请上传汇款凭证" toView:self.view];
        return;
    }
    underMoney.pic = pic;
    if ([_descTV.text isEqualToString:@"请填写汇款说明"]) {
        underMoney.desc = @"";
    } else {
        underMoney.desc = _descTV.text;
    }
    underMoney.pay_password = _pay_passwordTF.text;
    [MBProgressHUD showMessage:nil toView:self.view];
    [underMoney sUserBalanceUnderMoneySuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
