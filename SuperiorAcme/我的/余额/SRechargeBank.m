//
//  SRechargeBank.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRechargeBank.h"
#import "SBankCell.h"
#import "CQPlaceholderView.h"
#import "SUserBalanceBankList.h"
#import "SUserBalancePlatformAccount.h"
#import "SBankAdd.h"
#import "SUserBalanceDelBank.h"

@interface SRechargeBank () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    CQPlaceholderView *placeholderView;
    NSArray * arr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SRechargeBank

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SBankCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SBankCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    
}
- (void)viewDidAppear:(BOOL)animated {
    [self showModel];
}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {
    
    [self showModel];
}
- (void)showModel {
    if (_type == NO) {
        SUserBalanceBankList * list = [[SUserBalanceBankList alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserBalanceBankListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SUserBalanceBankList * list = (SUserBalanceBankList *)data;
            arr = list.data;
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        SUserBalancePlatformAccount * list = [[SUserBalancePlatformAccount alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserBalancePlatformAccountSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SUserBalancePlatformAccount * list = (SUserBalancePlatformAccount *)data;
            arr = list.data;
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    if (_type == NO) {
        self.title = @"我的银行卡";
    } else {
        self.title = @"平台银行卡";
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
    
    if (_type == NO) {
        UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rigthBtn.frame = CGRectMake(0, 0, 44, 50);
        [rigthBtn setImage:[UIImage imageNamed:@"添加银行卡"] forState:UIControlStateNormal];
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rigthBtnClick {
    SBankAdd * add = [[SBankAdd alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ceil(ScreenW/1170*300);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBankCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SBankCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.oneBtn setTag:indexPath.section];
    [cell.twoBtn setTag:indexPath.section];
    [cell.oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_type == NO) {
        cell.bank_card_code_WWW.constant = 25;
        cell.bank_name_WWW.constant = 25;
        cell.bank_pic.hidden = YES;
        SUserBalanceBankList * list = arr[indexPath.section];
        cell.bank_card_code.text = [NSString stringWithFormat:@"银行卡号:  %@",list.bank_card_code];
        cell.bank_name.text = [NSString stringWithFormat:@"开  户  行：%@\n户        名：%@\n手  机  号：%@",list.open_bank,list.name,list.phone];
//        [cell.bank_pic sd_setImageWithURL:[NSURL URLWithString:list.bank_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];

    } else {
        cell.bank_card_code_WWW.constant = 25;
        cell.bank_name_WWW.constant = 25;
        cell.oneBtn.hidden = YES;
        cell.twoBtn.hidden = YES;
        cell.bank_pic.hidden = YES;
        SUserBalancePlatformAccount * list = arr[indexPath.section];
        cell.bank_card_code.text = [NSString stringWithFormat:@"平台卡号:  %@",list.bank_num];
        cell.bank_name.text = [NSString stringWithFormat:@"开  户  行：%@\n户        名：%@",list.open_bank,list.bank_name];

    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == NO) {
        SUserBalanceBankList * list = arr[indexPath.section];
        if (self.SRechargeBank_choice) {
            self.SRechargeBank_choice(list.bank_card_id,list.bank_card_code);
        }
    } else {
        SUserBalancePlatformAccount * list = arr[indexPath.section];
        if (self.SRechargeBank_choice) {
            self.SRechargeBank_choice(list.id,list.bank_num);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)oneBtnClick:(UIButton *)btn {
    SUserBalanceBankList * list = arr[btn.tag];
    SBankAdd * add = [[SBankAdd alloc] init];
    add.bank_card_id = list.bank_card_id;
    add.bank_type_id = list.bank_type_id;
    add.bank_card_code = list.bank_card_code;
    add.bank_name = list.bank_name;
    add.open_bank = list.open_bank;
    add.name = list.name;
    add.phone = list.phone;
    [self.navigationController pushViewController:add animated:YES];
}
- (void)twoBtnClick:(UIButton *)btn {
    SUserBalanceBankList * list = arr[btn.tag];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"删除银行卡?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SUserBalanceDelBank * del = [[SUserBalanceDelBank alloc] init];
        del.bank_card_id = list.bank_card_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [del sUserBalanceDelBankSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [self showModel];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
