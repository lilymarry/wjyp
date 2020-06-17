//
//  SBankAdd.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBankAdd.h"
#import "SBankAdd_type.h"
#import "SUserBalanceAddBank.h"
#import "SUserBalanceEditBank.h"
#import "SUserUserInfo.h"

@interface SBankAdd ()
{
    NSString * model_bank_type_id;
    NSString * name_1;//个人
    NSString * name_2;//企业
}
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *choice_bankType;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *choice_bankTypeTF;
@property (strong, nonatomic) IBOutlet UITextField *open_bankTF;
@property (strong, nonatomic) IBOutlet UITextField *card_numberTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@end

@implementation SBankAdd

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_choice_bankType addTarget:self action:@selector(choice_bankTypeClick) forControlEvents:UIControlEventTouchUpInside];
    
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        SUserUserInfo * userInfo = (SUserUserInfo *)data;
        if ([userInfo.data.auth_status integerValue] == 2) {
            name_1 = userInfo.data.auth_name;
        } else {
            name_1 = @"";
        }
        if ([userInfo.data.comp_auth_status integerValue] == 2) {
            name_2 = userInfo.data.comp_auth_name;
        } else {
            name_2 = @"";
        }
    } andFailure:^(NSError *error) {
    }];
    
    if (_bank_card_id != nil) {
        _nameTF.text = _name;
        _choice_bankTypeTF.text = _bank_name;
        model_bank_type_id = _bank_type_id;
        _open_bankTF.text = _open_bank;
        _card_numberTF.text = _bank_card_code;
        _phoneTF.text = _phone;
        [_submitBtn setTitle:@"修改" forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_bank_card_id == nil) {
        self.title = @"添加银行卡";
    } else {
        self.title = @"修改银行卡";
    }
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
- (void)choice_bankTypeClick {
    SBankAdd_type * add_type = [[SBankAdd_type alloc] init];
    [self.navigationController pushViewController:add_type animated:YES];
    add_type.SBankAdd_type_choice = ^(NSString *bank_type_id, NSString *bank_name) {
        _choice_bankTypeTF.text = bank_name;
        model_bank_type_id = bank_type_id;
        _open_bankTF.text = @"";
        _card_numberTF.text = @"";
    };
}
- (void)submitBtnClick {
    if ([_nameTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写持卡人姓名" toView:self.view];
        return;
    }
    if (model_bank_type_id == nil) {
        [MBProgressHUD showError:@"请选择银行卡类型" toView:self.view];
        return;
    }
    if ([_open_bankTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写银行卡开户行" toView:self.view];
        return;
    }
    if ([_card_numberTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写银行卡卡号" toView:self.view];
        return;
    }
    if ([_phoneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写预留手机号" toView:self.view];
        return;
    }
    if (_bank_card_id == nil) {
        //添加
        SUserBalanceAddBank * addBank = [[SUserBalanceAddBank alloc] init];
        addBank.name = _nameTF.text;
        addBank.bank_type_id = model_bank_type_id;
        addBank.open_bank = _open_bankTF.text;
        addBank.card_number = _card_numberTF.text;
        addBank.phone = _phoneTF.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [addBank sUserBalanceAddBankSuccess:^(NSString *code, NSString *message) {
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
    } else {
        //修改
        SUserBalanceEditBank * editBank = [[SUserBalanceEditBank alloc] init];
        editBank.bank_card_id = _bank_card_id;
        editBank.name = _nameTF.text;
        editBank.bank_type_id = model_bank_type_id;
        editBank.open_bank = _open_bankTF.text;
        editBank.card_number = _card_numberTF.text;
        editBank.phone = _phoneTF.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [editBank sUserBalanceEditBankSuccess:^(NSString *code, NSString *message) {
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
}
- (IBAction)nameBtn:(UIButton *)sender {
    
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"请选择持卡人姓名"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:name_2 style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             _nameTF.text = name_2;
                                                         }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:name_1 style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //响应事件
                                                           _nameTF.text = name_1;
                                                       }];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    if (![name_2 isEqualToString:@""]) {
        [alert addAction:deleteAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}
@end
