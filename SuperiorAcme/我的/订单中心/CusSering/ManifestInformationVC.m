//
//  ManifestInformationVC.m
//  TaoMiShop
//
//  Created by zhaobaofeng on 16/8/9.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import "ManifestInformationVC.h"
#import "AcceptCompanyVC.h"//物流
#import "SAfterSaleAddShipping.h"//提交
#import "DatePicker_Country.h"
#import "SAddress_choice.h"

@interface ManifestInformationVC () <UITextViewDelegate>
{
    NSString * this_delivery_id;//快递id
    NSString * province_id;//省id
    NSString * city_id;//市id
    NSString * area_id;//区县id
    NSString * street_id;//街道id
}
@property (strong, nonatomic) IBOutlet UILabel *selectCompany;//承运公司
@property (strong, nonatomic) IBOutlet UITextField *orderNum;
@property (strong, nonatomic) IBOutlet UITextField *receiverTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *oneTF;
@property (strong, nonatomic) IBOutlet UITextField *twoTF;
@property (strong, nonatomic) IBOutlet UITextView *addressTV;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation ManifestInformationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    _addressTV.delegate = self;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"运单信息";
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
#pragma mark -选择公司
- (IBAction)selectCompany:(UIButton *)sender {
    if ([_orderNum.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入快递单号!" toView:self.view];
        return;
    } else if (_orderNum.text.length < 5) {
        [MBProgressHUD showError:@"快递单号需大于5位数" toView:self.view];
        return;
    }
    AcceptCompanyVC * accept = [[AcceptCompanyVC alloc] init];
    accept.expressOrderSN = self.orderNum.text;
    [self.navigationController pushViewController:accept animated:YES];
    accept.AcceptCompanyVC_delivery = ^(NSString * delivery_id, NSString * delivery_name) {
        this_delivery_id = delivery_id;
        _selectCompany.text = delivery_name;
    };
}

#pragma mark -确认
- (IBAction)commit:(UIButton *)sender {
    [_orderNum resignFirstResponder];
    if (this_delivery_id == nil) {
        [MBProgressHUD showError:@"请选择承运公司" toView:self.view];
        return;
    }
    if ([_orderNum.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写承运号码" toView:self.view];
        return;
    }
    if ([_receiverTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写姓名" toView:self.view];
        return;
    }
    if ([_phoneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写电话" toView:self.view];
        return;
    }
    if ([_oneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择所在地区" toView:self.view];
        return;
    }
    if ([_twoTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择所在街道" toView:self.view];
        return;
    }
    SAfterSaleAddShipping * order = [[SAfterSaleAddShipping alloc] init];
    order.shipping_id = _selectCompany.text;
    order.invoice = _orderNum.text;
    order.back_apply_id = _back_apply_id;
    order.receiver = _receiverTF.text;
    order.receiver_phone = _phoneTF.text;
    order.province = province_id;
    order.city = city_id;
    order.area = area_id;
    order.street = street_id;
    order.address = _addressTV.text;
    [MBProgressHUD showMessage:nil toView:self.view];
    [order sAfterSaleAddShippingSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:_infor_back animated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 所在地区
- (IBAction)oneBtn:(UIButton *)sender {
    
    UIView * backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backGroundView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    [self.view addSubview:view];
    
    DatePicker_Country * pick = [[DatePicker_Country alloc] init];
    pick.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:pick animated:YES completion:nil];
    
    pick.DatePicker_Country_Back = ^{
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
    pick.DatePicker_Country_Submit = ^(NSString *one, NSString *two, NSString *three, NSString *one_id, NSString *two_id, NSString *three_id) {
        _twoTF.text = @"";
        street_id = @"";
        
        _oneTF.text = [NSString stringWithFormat:@"%@%@%@",one,two,three];
        province_id = one_id;
        city_id = two_id;
        area_id = three_id;
        [backGroundView removeFromSuperview];
        [view removeFromSuperview];
    };
}
#pragma mark - 所在街道
- (IBAction)twoBtn:(UIButton *)sender {
    SAddress_choice * choiceAdd = [[SAddress_choice alloc] init];
    if (area_id == nil || [area_id isEqualToString:@""]) {
        [MBProgressHUD showError:@"请先选择省份" toView:self.view];
        return;
    }
    choiceAdd.area_id = area_id;
    [self.navigationController pushViewController:choiceAdd animated:YES];
    choiceAdd.SAddress_choice_choice = ^(NSString *thisName, NSString *this_id) {
        _twoTF.text = thisName;
        street_id = this_id;
    };
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入退换货人详细地址"]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入退换货人详细地址";
        textView.textColor = WordColor_30;
    } else {
        textView.textColor = WordColor;
    }
    return YES;
}
@end
