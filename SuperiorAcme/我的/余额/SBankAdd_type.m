//
//  SBankAdd_type.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBankAdd_type.h"
#import "SBankAdd_typeCell.h"
#import "SUserBalanceGetBankType.h"
#import "CQPlaceholderView.h"
#import "SUserBalanceSearchBank.h"

@interface SBankAdd_type () <UITableViewDelegate,UITableViewDataSource,CQPlaceholderViewDelegate>
{
    NSArray * arr;
    CQPlaceholderView *placeholderView;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@end

@implementation SBankAdd_type

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];

    [_mTable registerNib:[UINib nibWithNibName:@"SBankAdd_typeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SBankAdd_typeCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    placeholderView = [[CQPlaceholderView alloc]initWithFrame:CGRectMake(ScreenW/2 - 100, _mTable.frame.size.height/2 - 100 - 64, 200, 200) type:CQPlaceholderViewTypeNoOrder delegate:self];
    [_mTable addSubview:placeholderView];
    placeholderView.hidden = YES;
    [self showModel];
    
    [_searchTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

}
#pragma mark - 占位图重新加载
- (void)placeholderView:(CQPlaceholderView *)placeholderView {

    [self showModel];
}
- (void)showModel {
    SUserBalanceGetBankType * list = [[SUserBalanceGetBankType alloc] init];
//    [MBProgressHUD showMessage:nil toView:self.view];
    [list sUserBalanceGetBankTypeSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SUserBalanceGetBankType * list = (SUserBalanceGetBankType *)data;
        arr = list.data;
        [_mTable reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"银行卡";
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (arr.count == 0) {
        placeholderView.hidden = NO;
    } else {
        placeholderView.hidden = YES;
    }
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBankAdd_typeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SBankAdd_typeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_searchTF.text isEqualToString:@""]) {
        SUserBalanceGetBankType * list = arr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.bank_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.bank_name;
    } else {
        SUserBalanceSearchBank * list = arr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:list.bank_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.bank_name;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_searchTF.text isEqualToString:@""]) {
        SUserBalanceGetBankType * list = arr[indexPath.row];
        if (self.SBankAdd_type_choice) {
            self.SBankAdd_type_choice(list.bank_type_id, list.bank_name);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        SUserBalanceSearchBank * list = arr[indexPath.row];
        if (self.SBankAdd_type_choice) {
            self.SBankAdd_type_choice(list.bank_type_id, list.bank_name);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)textFieldChanged:(UITextField *)field {
    if ([field.text isEqualToString:@""]) {
        [self showModel];
    } else {
        SUserBalanceSearchBank * search = [[SUserBalanceSearchBank alloc] init];
        search.bank_name = field.text;
        [search sUserBalanceSearchBankSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SUserBalanceSearchBank * list = (SUserBalanceSearchBank *)data;
            arr = list.data;
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
}
@end
