//
//  Sintegral.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "Sintegral.h"
#import "SShopCouponUseCan.h"
#import "Sintegral_sub.h"
#import "SUserMyIntegral.h"
#import "SMessageInfor.h"
#import "SUserChangeIntegralStatus.h"
#import "WAMoney.h"
#import "SUserUserCenter.h"
@interface Sintegral ()
{
    NSString * url_str;
    NSString * my_change_integral;
    NSString * integral_percentage;
    NSString * model_des;
    BOOL isYouxiang;
}
@property (strong, nonatomic) IBOutlet UIButton *intergralInforBtn;
@property (strong, nonatomic) IBOutlet UILabel *thisContent;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *nowTime;
@property (weak, nonatomic) IBOutlet UIButton *pointNum;
@property (weak, nonatomic) IBOutlet UISwitch *mSw;
@property (weak, nonatomic) IBOutlet UIView *mSw_ground;
@property (weak, nonatomic) IBOutlet UIView *user_card_type_ground;


@property (strong, nonatomic) IBOutlet UILabel *my_integral;
@property (weak, nonatomic) IBOutlet UILabel *thisDate;

@property (weak, nonatomic) IBOutlet UIImageView *backImag;
@property (weak, nonatomic) IBOutlet UILabel *lab_tittle;

@property (strong, nonatomic) IBOutlet UIView *yingliangListView;

@property (strong, nonatomic) IBOutlet UIButton *yinliangListBtn;



@end

@implementation Sintegral

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
//    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"今日您可使用666积分兑换666余额\n另赠送您666代金券"];
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, 3)];
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 3)];
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(23, 3)];
//    _thisContent.attributedText = AttributedStr;
    
}
-(void)yinliangrBtnClick
{
    WAMoney * vc4 = [[WAMoney alloc] init];

    vc4.presentingView=YES;
    vc4.type=@"1";
    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];

    [nav4.navigationBar setBarTintColor:navigationColor];
    nav4.navigationBar.tintColor = [UIColor whiteColor];
    nav4.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self presentViewController:nav4 animated:YES completion:nil];
}

/**
 判断显示兑换积分相关View
 */
- (void)isShowExchangeView {
    
//    if (_complete_status != nil) {
//        //使用新规则
//        if ([_complete_status isEqualToString:@"1"]) return;
//    }
//
//    NSInteger num = [_user_card_type integerValue];
//    switch (num) {
//        case 1:
//            _user_card_type_ground.hidden = NO;
//            break;
//        case 2:
//            _mSw_ground.hidden = NO;
//            break;
//        default:
//            break;
//    }
    
    if ([_uct_status intValue]==1) {
        _complete_status=@"2";
        _user_card_type=@"2";
        
    }
    
    if ([_complete_status intValue]!=0) {
        if ([_complete_status intValue]==1||[_user_card_type intValue]==3) {
            _user_card_type_ground.hidden = YES;
            _mSw_ground.hidden = YES;
        }
        else if ([_user_card_type intValue]==2)
        {
            _user_card_type_ground.hidden = YES;
            _mSw_ground.hidden = NO;//自动转换
            
        }
        else{
           _user_card_type_ground.hidden = NO;
        }
       
    }
    else
    {
            NSInteger num = [_user_card_type integerValue];
            switch (num) {
                case 1:
                    _user_card_type_ground.hidden = NO;
                    break;
                case 2:
                    _mSw_ground.hidden = NO;
                    break;
                case 3:
                    isYouxiang = YES;
                    break;
                default:
                    break;
            }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
     if ([_type isEqualToString:@"1"]) {
         
    self.title = @"积分";
     }
    else
    {
        self.title = @"银两";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    if ([_type isEqualToString:@"1"]) {
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY.MM.dd"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
        NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
        _nowTime.text = nowtimeStr;
        
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        
        [_intergralInforBtn addTarget:self action:@selector(intergralInforBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        isYouxiang=NO;
        //判断显示兑换积分相关View
        [self isShowExchangeView];
    }
    else
    {
        _user_card_type_ground.hidden=NO;
        _backImag.image=[UIImage imageNamed:@"余额背景"];
        _lab_tittle.text=@"我的银子(两)";
     
        [_intergralInforBtn setTitle:@" 银两充值" forState:UIControlStateNormal];
        [_intergralInforBtn setImage: [UIImage imageNamed:@"充值标识"] forState:UIControlStateNormal];
        [_intergralInforBtn addTarget:self action:@selector(yinliangrBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _yingliangListView.hidden=NO;
        [_yinliangListBtn addTarget:self action:@selector(intergralInforBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self showModel];
        
        
    }
    
}
- (void)showModel {
    SUserUserCenter * center = [[SUserUserCenter alloc] init];
 
    [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
       
     
        if ([code isEqualToString:@"1"]) {
            SUserUserCenter * center = (SUserUserCenter *)data;
           
           _my_integral.text=center.data.chance_num;
           
        } else {
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[SRegisterLogin shareInstance] deleteUserInfo];
                EMError *error_err = [[EMClient sharedClient] logout:YES];
                SLand * land = [[SLand alloc] init];
                UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                self.view.window.rootViewController = landNav;
            });
        }
        
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    
      if ([_type isEqualToString:@"1"]) {
    SUserMyIntegral * integral = [[SUserMyIntegral alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [integral sUserMyIntegralSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserMyIntegral * integral = (SUserMyIntegral *)data;
            url_str = integral.data.article;
  
            ////超时判断 1 不能兑换 0 可以  2.会员等级判断 1 不能兑换  0 可以  3.积分小于100 不可以兑换
            if ([integral.data.time_out_status integerValue] == 1 || [integral.data.user_card_status integerValue] == 1 || ([integral.data.my_integral floatValue] < 100)) {
                [_submitBtn setBackgroundColor:WordColor_30];
                _submitBtn.userInteractionEnabled = NO;
                [_submitBtn setTitle:@"今日不可兑换" forState:UIControlStateNormal];
            } else {
                     if ([integral.data.exchange_status isEqualToString:@"1"]) {
                        [_submitBtn setBackgroundColor:WordColor_30];
                        _submitBtn.userInteractionEnabled = NO;
                        [_submitBtn setTitle:@"今天已兑换" forState:UIControlStateNormal];
                    } else {
                        
                        [_submitBtn setBackgroundColor:[UIColor redColor]];
                        _submitBtn.userInteractionEnabled = YES;
                        [_submitBtn setTitle:@"前往兑换" forState:UIControlStateNormal];
                }
            }
            
            _my_integral.text = integral.data.my_integral;
            integral_percentage = integral.data.integral_percentage;
            if (isYouxiang &&[integral.data.status integerValue] == 1) {
                [_mSw setOn:YES];
            } else {
                [_mSw setOn:NO];
            }
//            if ([integral.data.auto_status integerValue] == 1) {
//                _mSw_ground.hidden = NO;
//            } else {
//                _mSw_ground.hidden = YES;
//            }
            SUserMyIntegral * first = integral.data.point_list.firstObject;
            
//            _thisContent.text = @"积分兑换额度=积分总额*无界指数，实际可兑换额度按10的倍数向下取整，最低兑换额度不小于10积分。";
            
            /*
             *修改thisContent属性的内容跟随服务器返回的数据进行显示
             *在SUserMyIntegral模型中添加属性point_desc
             */
            _thisContent.text = integral.data.point_desc;
            
            _thisDate.text = [NSString stringWithFormat:@"提示：今日若不兑换，此兑换机会将作废 兑换时间：%@",first.date];
            model_des = first.change;
            [_pointNum setTitle:[NSString stringWithFormat:@" 无界指数%@",first.point_num] forState:UIControlStateNormal];
            my_change_integral = first.my_change_integral;
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
      }
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
- (void)intergralInforBtnClick {
    
    SShopCouponUseCan *useCan=[[SShopCouponUseCan alloc]init];
    if ([_type isEqualToString:@"1"]) {
     
        useCan.type = @"2";
       
    }
    else
    {
        useCan.type = @"9";
    }
     [self.navigationController pushViewController:useCan animated:YES];

}
- (void)submitBtnClick {
    Sintegral_sub * subm = [[Sintegral_sub alloc] init];
    subm.my_integral = my_change_integral;
    subm.integral_percentage = integral_percentage;
    subm.model_des = model_des;
    [self.navigationController pushViewController:subm animated:YES];
}

- (IBAction)agreementBtn:(UIButton *)sender {
    SMessageInfor * infor = [[SMessageInfor alloc] init];
    infor.type = @"积分协议";
    infor.code_Url = url_str;
    [self.navigationController pushViewController:infor animated:YES];
}
- (IBAction)mSw:(UISwitch *)sender {
    
    SUserChangeIntegralStatus * sss = [[SUserChangeIntegralStatus alloc] init];
    if (sender.on == NO) {
        NSLog(@"开");
        sss.status = @"1";
    } else {
        NSLog(@"关");
        sss.status = @"0";
    }
    [sss sUserChangeIntegralStatusSuccess:^(NSString *code, NSString *message) {
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
