//
//  SBalance.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBalance.h"
#import "SRecharge.h"
#import "SWithdrawals.h"
#import "SShopCouponUseCan.h"
#import "STransferAccounts.h"
#import "SUserBalanceBalanceIndex.h"
#import "SUserUserInfo.h"
#import "SPersonalData.h"
#import "SRealNameAuth.h"
#import "ShopCodeList.h"
#import "SlineDetailWebController.h"
@interface SBalance ()<ShopCodeListDelegate>
{
    NSString * model_nowBalance;
    ShopCodeList *choseview;
    UIView *bgView ; //遮罩层
     BOOL isshow;
}
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneView_HHH;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoView_HHH;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *price_title;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *fourView;


@property (weak, nonatomic) IBOutlet UILabel *giveLabel;

@property (weak, nonatomic) IBOutlet UILabel *giveBalanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *lab_tixian;

@property (weak, nonatomic) IBOutlet UIView *fiveView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fiveView_HHH;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UILabel *fiveLab;


@end

@implementation SBalance

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //类型 1余额 2赠送代金券
    if ([_viewType isEqualToString:@"1"]) {
        [self createBalance];
    } else {
        [self createCoupon];
    }
    isshow =NO;
}

- (void)createCoupon {
    [self createNav];
  //  _lab_tixian.text=@"收益明细";
    _giveLabel.text = @"赠送";
    _giveBalanceLabel.text = @"赠送明细";
    _fiveLab.text=@"收益明细";
    //赠送
    [_fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //赠送明细
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //收益明细
    [_fiveBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createBalance {
    [self createNav];
    if ([_alliance_merchant integerValue]>0) {
       //  充值 提现 转账 余额明细
        _oneView.hidden=NO;
        _twoView.hidden=NO;
        _threeView.hidden=NO;
        _fourView.hidden=NO;
    }
    else
    {
        if ([_user_card_type integerValue]==2 ||([_shopid integerValue]>0&&[_user_card_type integerValue]!=3)) {
            //  充值 提现 余额明细
            _oneView.hidden=NO;
            _twoView.hidden=NO;
            _threeView.hidden=YES;
            _threeView_HHH.constant=0;
            _fourView.hidden=NO;
        }
        else if ([_user_card_type integerValue]==3)
        {
             // 充值 提现 转账 余额明细
            _oneView.hidden=NO;
            _twoView.hidden=NO;
            _threeView.hidden=NO;
            _fourView.hidden=NO;
        }
        else
        {
             //  充值 余额明细
            _oneView.hidden=NO;
            _twoView.hidden=YES;
            _twoView_HHH.constant=0;
            _threeView.hidden=YES;
            _threeView_HHH.constant=0;
            _fourView.hidden=NO;
            
        }
    }
    
    
    
    //充值
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //提现
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //余额明细
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //转账
    [_fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if ([_viewType isEqualToString:@"1"]) {
        self.title = @"余额";
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        _fiveView_HHH.constant=0;
        _fiveView.hidden=YES;
//        if (_complete_status != nil) {
//            //使用新规则
//            if (![_complete_status isEqualToString:@"1"]) {
//                if ([_user_card_type integerValue] < 2) {
//                    _twoView.hidden = YES;
//                    _twoView_HHH.constant = 0;
//                }
//                _threeView.hidden = YES;
//                _threeView_HHH.constant = 0;
//            }
//        } else {
//            //使用老规则
//            if ([_user_card_type integerValue] < 2) {
//                _twoView.hidden = YES;
//                _twoView_HHH.constant = 0;
//                _threeView.hidden = YES;
//                _threeView_HHH.constant = 0;
//            }
//            if ([_user_card_type integerValue] < 3) {
//                _threeView.hidden = YES;
//                _threeView_HHH.constant = 0;
//            }
//        }
        
    } else {
        self.title = @"赠送蓝色代金券";
        _price_title.text = @"蓝色代金券金额";
        _backImageView.image = [UIImage imageNamed:@"赠送蓝色代金券背景图"];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
        _oneView.hidden = YES;
        _oneView_HHH.constant = 0;
        _twoView.hidden = YES;
        _twoView_HHH.constant = 0;
        
    }
}
- (void)viewDidAppear:(BOOL)animated {
    if ([_viewType isEqualToString:@"1"]) {
        SUserBalanceBalanceIndex * infor = [[SUserBalanceBalanceIndex alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sUserBalanceBalanceIndexSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SUserBalanceBalanceIndex * infor = (SUserBalanceBalanceIndex *)data;
                _balance.text = infor.data.balance;
                model_nowBalance = infor.data.balance;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        _balance.text = _blueCouponBalance;
        model_nowBalance = _blueCouponBalance;
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
#pragma mark - 充值
- (void)oneBtnClick {
    SRecharge * rech = [[SRecharge alloc] init];
   [self.navigationController pushViewController:rech animated:YES];
}
#pragma mark - 提现 赠送代金券明细
- (void)twoBtnClick {
    
    if ([_viewType isEqualToString:@"1"]) {
        [self toSWithdrawals];
    } else {
       NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/ExIntegral/sendBlueVouchersPreRevenue.html", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.urlStr=detail_Base_url;
        conter.fag=@"11";
      //  [self presentViewController:conter animated:YES completion:nil];
          [self.navigationController pushViewController:conter animated:YES];
    }
    
}
//提现
-(void)toSWithdrawals
{
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
                SWithdrawals * with = [[SWithdrawals alloc] init];
                [self.navigationController pushViewController:with animated:YES];
            }
        }
    } andFailure:^(NSError *error) {
    }];
}
#pragma mark - 余额明细
- (void)threeBtnClick {
    SShopCouponUseCan * useCan = [[SShopCouponUseCan alloc] init];
    if ([_viewType isEqualToString:@"1"]) {
        useCan.type = @"3";
    } else {
        useCan.type = @"6";
    }
    [self.navigationController pushViewController:useCan animated:YES];
}
#pragma mark - 转账
- (void)fourBtnClick {

    //旧代码
//    STransferAccounts * account = [[STransferAccounts alloc] init];
//    account.nowBalance = model_nowBalance;
//    if ([_viewType isEqualToString:@"1"]) {
//        account.type = @"1";
//    } else {
//        account.type = @"2";
//        account.changeNowBalance = ^(NSString *balance) {
//            _blueCouponBalance = balance;
//            _balance.text = _blueCouponBalance;
//            model_nowBalance = _blueCouponBalance;
//        };
//    }
//    [self.navigationController pushViewController:account animated:YES];
    
    /*
     *先验证是否实名认证,根绝是否已经实名认证,决定能否转赠蓝券
     */
    [self RealNameAuthenticationWithAlreadyCertification:^{
        if ([_viewType isEqualToString:@"1"]) {
            STransferAccounts * account = [[STransferAccounts alloc] init];
                account.nowBalance = model_nowBalance;
                account.type = @"1";
            
                account.changeNowBalance = ^(NSString *balance) {
                    _blueCouponBalance = balance;
                    _balance.text = _blueCouponBalance;
                    model_nowBalance = _blueCouponBalance;
                };
           
            [self.navigationController pushViewController:account animated:YES];
        }
        else
        {
            if(_blueTickArr.count>0)
            {
                if(isshow==NO)
                {
                    isshow=YES;
                    [self showThebgview];
                    choseview =[[ShopCodeList alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 250)];
                    choseview.dDelegate=self;
                    choseview.shopArr=_blueTickArr;
                    choseview.state=@"3";
                    
                    [choseview reloadTable];
                    [self.view.window addSubview:choseview];
                
                }
            }
            else
            {
                STransferAccounts * account = [[STransferAccounts alloc] init];
                account.nowBalance = model_nowBalance;
                
                if ([_viewType isEqualToString:@"1"]) {
                    account.type = @"1";
                } else {
                    account.type = @"2";
                    account.shopid=@"";
                    account.changeNowBalance = ^(NSString *balance) {
                        _blueCouponBalance = balance;
                        _balance.text = _blueCouponBalance;
                        model_nowBalance = _blueCouponBalance;
                    };
                }
                [self.navigationController pushViewController:account animated:YES];
                
            }
        }
    
   }];
}
-(void)selectShopCodeListData:(NSDictionary *)dic state:(NSString *)state
{
           [self hidThebgview];
           [choseview removeFromSuperview];
            STransferAccounts * account = [[STransferAccounts alloc] init];
            account.nowBalance = model_nowBalance;
          
            if ([_viewType isEqualToString:@"1"]) {
                account.type = @"1";
            } else {
                account.type = @"2";
                account.shopid=dic[@"stage_merchant_id"];
                account.changeNowBalance = ^(NSString *balance) {
                    _blueCouponBalance = balance;
                    _balance.text = _blueCouponBalance;
                    model_nowBalance = _blueCouponBalance;
                };
            }
            [self.navigationController pushViewController:account animated:YES];
    
}
/*
 *添加实名认证验证方法
 */
#pragma mark - 实名认证验证
-(void)RealNameAuthenticationWithAlreadyCertification:(void (^)())AlreadyCertificationBlock{
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
            } else  {
                //已经实名认证
                AlreadyCertificationBlock();
            }
        }
    } andFailure:^(NSError *error) {
    }];
}
//加载背景蒙板
-(void)showThebgview{
  
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
    bgView.backgroundColor=[UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:1];
    bgView.alpha=0;
    [self.view.window addSubview:bgView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTheView:)];
    tapGesture.numberOfTapsRequired=1;
    [bgView addGestureRecognizer:tapGesture];
    
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0.8;
        
    }completion:^(BOOL finished){
        
    } ];
}
//撤销背景蒙板
-(void)hidThebgview{
      isshow=NO;
    [UIView animateWithDuration:0.3 animations:^(){
        bgView.alpha=0;
    }completion:^(BOOL finished){
        [bgView removeFromSuperview];
    } ];
}
//销毁查询菜单view
-(void)removeTheView:(UITapGestureRecognizer*)gesture{
    [self hidThebgview];
    [choseview removeFromSuperview];
}
@end
