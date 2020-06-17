//
//  SBusinessQualification.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBusinessQualification.h"
#import "SBusinessQualificationCell.h"

#import "SMerchantLicense.h"
#import "SMerchantReportType.h"

@interface SBusinessQualification () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr_one;
    NSArray * arr_two;
    NSArray * brr;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@end

@implementation SBusinessQualification

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    [_mTable registerNib:[UINib nibWithNibName:@"SBusinessQualificationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SBusinessQualificationCell"];
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == NO) {
        self.title = @"商家资质";
        
        SMerchantLicense * list = [[SMerchantLicense alloc] init];
        list.merchant_id = _merchant_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantLicenseSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SMerchantLicense * list = (SMerchantLicense *)data;
                arr_one = list.data;
                [_mTable reloadData];
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else {
        self.title = @"举报类型";
        
        SMerchantReportType * list = [[SMerchantReportType alloc] init];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMerchantReportTypeSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SMerchantReportType * list = (SMerchantReportType *)data;
                brr = list.data;
                [_mTable reloadData];
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == NO) {
        if (SWNOTEmptyArr(_other_license)){
            return [_other_license count];
        }
        return arr_one.count;
    }
    return brr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBusinessQualificationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SBusinessQualificationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_type == NO) {
        
        if (SWNOTEmptyArr(_other_license)) {
            UBShopLicenseModel *aModel = _other_license[indexPath.row];
            cell.one.text = aModel.license_name;
            cell.two.text = @"已认证";
            return cell;
        }
        SMerchantLicense * list = arr_one[indexPath.row];
        cell.one.text = list.name;
        if ([list.status isEqualToString:@"0"]) {
            cell.two.text = @"未认证";
        } else {
            cell.two.text = @"已认证";

        }
    } else {
        SMerchantReportType * list = brr[indexPath.row];
        cell.one.text = list.title;
        cell.two.hidden = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == YES) {
        SMerchantReportType * list = brr[indexPath.row];
        if (self.SBusinessQualification_choice) {
            self.SBusinessQualification_choice(list.report_type_id,list.title);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
