//
//  SWithdrawals.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWithdrawals.h"
#import "SBank.h"
#import "SUserBalanceCashIndex.h"
#import "SUserBalanceGetCash.h"

@interface SWithdrawals ()
{
    NSString * balance;
    NSString * model_bank_card_id;
    NSString * model_rate;
}
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (strong, nonatomic) IBOutlet UILabel *oneTitle;
@property (strong, nonatomic) IBOutlet UIButton *oneTitleBtn;
@property (strong, nonatomic) IBOutlet UILabel *twoTitle;
@property (strong, nonatomic) IBOutlet UILabel *threeTitle;
@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextField *bank_card_id_TF;
@property (strong, nonatomic) IBOutlet UITextField *pay_passwordTF;
@property (weak, nonatomic) IBOutlet UILabel *serviceChargeLabel;
@end

@implementation SWithdrawals

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    //注册监听UITextField完成输入通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawBalance:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    
    [_oneTitleBtn addTarget:self action:@selector(oneTitleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_choiceBtn addTarget:self action:@selector(choiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    SUserBalanceCashIndex * cash = [[SUserBalanceCashIndex alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [cash sUserBalanceCashIndexSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserBalanceCashIndex * cash = (SUserBalanceCashIndex *)data;
            
            NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可用余额￥%@",cash.data.balance]];
//            [AttributedStr addAttribute:NSForegroundColorAttributeName value:MyBlue range:NSMakeRange(6 + cash.data.balance.length, 4)];
            _oneTitle.attributedText = AttributedStr;
            
            balance = cash.data.balance;
            
            NSMutableAttributedString * AttributedStr_sub = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提现到银行卡，手续费率%@%%",cash.data.rate]];
            [AttributedStr_sub addAttribute:NSForegroundColorAttributeName value:MyBlue range:NSMakeRange(11, cash.data.rate.length + 1)];
            _twoTitle.attributedText = AttributedStr_sub;
            
            model_rate = cash.data.rate;
            
            NSMutableAttributedString * AttributedStr_sub_sub = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提现到账周期为%@，节假日顺延",cash.data.delay_time]];
            [AttributedStr_sub_sub addAttribute:NSForegroundColorAttributeName value:MyBlue range:NSMakeRange(7, cash.data.delay_time.length)];
            _threeTitle.attributedText = AttributedStr_sub_sub;
            
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    //注销所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"提现";
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
//    _numTF.text = balance;
}
- (void)choiceBtnClick {
    SBank * bank = [[SBank alloc] init];
    bank.choice_isno = YES;
    [self.navigationController pushViewController:bank animated:YES];
    bank.SBank_choice = ^(NSString *bank_card_id, NSString *bank_card_code) {
        _bank_card_id_TF.text = bank_card_code;
        model_bank_card_id = bank_card_id;
    };
}
-(void)changeButtonStatus{
    _submitBtn.enabled =YES;
}
- (void)submitBtnClick {
    _submitBtn.enabled=NO   ;
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:1.5f];//防止重复点击
    if ([_numTF.text integerValue] % 100 != 0) {
        //不是100倍数
        [MBProgressHUD showError:@"输入的提现金额不是100的倍数，请重新输入。" toView:self.view];
        _numTF.text = @"";
        [_numTF becomeFirstResponder];
        [self drawBalance:[[NSNotification alloc] initWithName:UITextFieldTextDidChangeNotification object:_numTF userInfo:nil]];
        return;
    }
    if (model_bank_card_id == nil) {
        [MBProgressHUD showError:@"请选择提现银行卡" toView:self.view];
        return;
    }
    SUserBalanceGetCash * getCash = [[SUserBalanceGetCash alloc] init];
    getCash.pay_password = _pay_passwordTF.text;
    getCash.money = _numTF.text;
    getCash.rate = model_rate;
    getCash.bank_card_id = model_bank_card_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [getCash sUserBalanceGetCashSuccess:^(NSString *code, NSString *message) {
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

- (void)drawBalance:(NSNotification *)n {
    if (n.object == _numTF) {
        //编辑提现金额
        CGFloat tmpFloat = [_numTF.text floatValue];//当前输入金额
        CGFloat balanceNum = [balance floatValue];//可用额度
        CGFloat maxNum = balanceNum > 50000 ? 50000 : balanceNum;//金额上限
        if (tmpFloat >= maxNum) {
            _numTF.text = [NSString stringWithFormat:@"%.0f", maxNum];
            tmpFloat = maxNum;
        }
        if (tmpFloat <= 0.00) {
            _numTF.text = @"";
            tmpFloat = 0;
        }
        CGFloat num = tmpFloat * 0.05;
        if (num >= 100) num = 100;
        _serviceChargeLabel.text = [NSString stringWithFormat:@"手续费:%.2f元", num];
    }
}
@end
