//
//  SShopCouponUseCan_infor.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCouponUseCan_infor.h"
#import "SUserBalanceGetUnderInfo.h"

@interface SShopCouponUseCan_infor ()

@property (strong, nonatomic) IBOutlet UILabel *thisStatus;
@property (strong, nonatomic) IBOutlet UILabel *card_number;
@property (strong, nonatomic) IBOutlet UILabel *card_name;
@property (strong, nonatomic) IBOutlet UILabel *open_bank;
@property (strong, nonatomic) IBOutlet UILabel *act_time;
@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *comNumber;
@property (weak, nonatomic) IBOutlet UILabel *comName;
@property (weak, nonatomic) IBOutlet UILabel *comBank;
@end

@implementation SShopCouponUseCan_infor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SUserBalanceGetUnderInfo * infor = [[SUserBalanceGetUnderInfo alloc] init];
    infor.act_id = _act_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [infor sUserBalanceGetUnderInfoSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserBalanceGetUnderInfo * infor = (SUserBalanceGetUnderInfo *)data;
            if ([infor.data.status isEqualToString:@"0"]) {
                _thisStatus.text = @"审核中";
            } else if ([infor.data.status isEqualToString:@"1"]) {
                _thisStatus.text = @"已完成";
            } else if ([infor.data.status isEqualToString:@"2"]) {
                _thisStatus.text = [NSString stringWithFormat:@"已拒绝,%@",infor.data.refuse_desc];
            }
            _card_number.text = infor.data.card_number;
            _card_name.text = infor.data.card_name;
            _open_bank.text = infor.data.open_bank;
            _act_time.text = infor.data.act_time;
            _money.text = infor.data.money;
            _name.text = infor.data.name;
            _comNumber.text = infor.data.p_bank_num;
            _comBank.text = infor.data.p_open_bank;
            _comName.text = infor.data.p_bank_name;
            [_pic sd_setImageWithURL:[NSURL URLWithString:infor.data.pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            _desc.text = infor.data.desc;
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
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
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"线下充值详情";

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

@end
