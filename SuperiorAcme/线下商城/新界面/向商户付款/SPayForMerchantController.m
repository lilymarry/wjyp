//
//  SPayForMerchantController.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SPayForMerchantController.h"
#import "CustomKeyboardView.h"
#import <IQKeyboardManager.h>
#import "SPay.h"
#import "UBShopDetailTableHelper.h"


#define kOfflineStore_offlineStoreInfo    @"OfflineStore/offlineStoreInfo"
#define CustomKeyboardHeight 287 * ScreenW/414
#define CustomKeyboardShowRect CGRectMake(0, ScreenH - CustomKeyboardHeight, ScreenW, CustomKeyboardHeight)

#define KeyboardDurationTime 0.35

@interface SPayForMerchantController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputMoneyTextField;
@property (weak, nonatomic) IBOutlet UIImageView *merchantIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *MerchantTitleLabel;
@property (nonatomic, strong) CustomKeyboardView * customKeyboardView;
@property (nonatomic, strong) UBShopDetailTableHelper *tableHelper;
@end

@implementation SPayForMerchantController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self CreatNavBar];
    //设置输入框的边框颜色
    self.inputMoneyTextField.layer.cornerRadius = 3.0f;
    self.inputMoneyTextField.layer.borderWidth = 1.0f;
    self.inputMoneyTextField.layer.borderColor = [UIColor colorWithRed:145.002/255.0 green:185.997/255.0 blue:241/255.0 alpha:1].CGColor;
    self.inputMoneyTextField.rightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 54 * ScreenW/414.0)];
    self.inputMoneyTextField.rightViewMode=UITextFieldViewModeAlways;

    //使用自定义键盘
    self.inputMoneyTextField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [self.view addSubview:self.customKeyboardView];
    
    if (SWNOTEmptyStr(_merchant_id)) {
        [self feachData];
    }

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //设置店铺头像的圆角
    self.merchantIconImageView.layer.cornerRadius = self.merchantIconImageView.bounds.size.width * 0.5;
    self.merchantIconImageView.layer.masksToBounds = YES;
    //设置自定义键盘的frame
    self.customKeyboardView.frame = CustomKeyboardShowRect;
}
#pragma mark - 创建NavigationBar
-(void)CreatNavBar{
    UIButton * leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBackBtn.frame = CGRectMake(0, 0, 30, 44);
    [leftBackBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    [leftBackBtn addTarget:self action:@selector(PopCurrentInterface) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
    
    UIButton * leftCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftCloseBtn.frame = CGRectMake(0, 0, 30, 44);
    [leftCloseBtn setImage:[UIImage imageNamed:@"X关闭"] forState:UIControlStateNormal];
    [leftCloseBtn addTarget:self action:@selector(PopToRootInterface) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftCloseBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftCloseBtn];
    
    
    UIView * merchantView = [[UIView alloc] init];
    merchantView.frame = CGRectMake(0, 0, 100, 19);
    UILabel * separatorLineLabel = [[UILabel alloc] init];
    separatorLineLabel.frame = CGRectMake(0, 0, 1, merchantView.bounds.size.height);
    separatorLineLabel.backgroundColor = [UIColor colorWithRed:153.002/255.0 green:153.002/255.0 blue:153.002/255.0 alpha:1];
    [merchantView addSubview:separatorLineLabel];
    
    UILabel * merchantNameLabel = [[UILabel alloc] init];
    merchantNameLabel.frame = CGRectMake(separatorLineLabel.bounds.size.width, 0, merchantView.bounds.size.width - 1, merchantView.bounds.size.height);
    merchantNameLabel.font = [UIFont systemFontOfSize:17];
    merchantNameLabel.textColor = [UIColor colorWithRed:51.0026/255.0 green:51.0026/255.0 blue:51.0026/255.0 alpha:1];
    merchantNameLabel.text = @"向商户付款";
    merchantNameLabel.textAlignment = NSTextAlignmentRight;
    [merchantView addSubview:merchantNameLabel];
    UIBarButtonItem * merchantBarItem = [[UIBarButtonItem alloc] initWithCustomView:merchantView];
    
    self.navigationItem.leftBarButtonItems = @[leftBackBarItem,leftCloseBarItem,merchantBarItem];
    
}
#pragma mark - 返回
//退回上一页
-(void)PopCurrentInterface{
    [self.navigationController popViewControllerAnimated:YES];
}
//退回到根控制器
-(void)PopToRootInterface{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 获取商家id
-(void)setUrl:(NSString *)url{
    _url = url;
//    self.merchant_id = @"38";
    if (SWNOTEmptyStr(url)) {
        NSRange range1 = [url rangeOfString:@"stage_merchant_id/"];
        NSRange range2 = [url rangeOfString:@"/invite_code"];
        NSUInteger location = range1.location + range1.length;
        NSUInteger length = range2.location - location;
        NSString * merchantIDStr = [url substringWithRange:NSMakeRange(location, length)];
        self.merchant_id = merchantIDStr;
        [self feachData];
    }
}

- (void)feachData{
    self.tableHelper = [UBShopDetailTableHelper new];
    [self.tableHelper fetchDataWihtPara:@{@"merchant_id":self.merchant_id,@"type":@"1",@"lng":@"",@"lat":@""}
                      completionHandler:^(UBShopDetailModel *shopDetailModel) {
                          self.MerchantTitleLabel.text = shopDetailModel.merchant_name;
                          [self.merchantIconImageView sd_setImageWithURL:[NSURL URLWithString:shopDetailModel.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
                      }];
}

#pragma mark - 跳转到支付界面
-(void)JumpToPayInterface{
    NSString *moneyStr = [self.inputMoneyTextField.text substringFromIndex:1];
    if ([moneyStr hasPrefix:@"."] || [moneyStr hasSuffix:@"."]) {
        [MBProgressHUD showSuccess:@"金额输入不正确" toView:self.view];
        return;
    }
//    if (moneyStr.integerValue < 1) {
//        [MBProgressHUD showSuccess:@"最小金额不能小于1" toView:self.view];
//        return;
//    }
    
    if (![self validateMoney:moneyStr]) {
        [MBProgressHUD showSuccess:@"最多输入两位小数" toView:self.view];
        return ;
    }
    
    SPay * pay = [[SPay alloc] init];
    pay.merchant_id = self.merchant_id;
    pay.pay_money = moneyStr;
    pay.model_type = @"线下商铺";
    pay.isPopRootVC = YES;
    [self.navigationController pushViewController:pay animated:YES];
}

-(BOOL)validateMoney:(NSString *)money
{
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}

#pragma mark - 自定义键盘
-(CustomKeyboardView *)customKeyboardView{
    if (!_customKeyboardView) {
        CustomKeyboardView * customKeyboardView = [[CustomKeyboardView alloc] initWithFrame:CGRectZero];
        _customKeyboardView = customKeyboardView;
        
        __weak typeof(self) WeakSelf = self;
        //点击数字回调
        customKeyboardView.ClickNumCallBackBlcok = ^(NSString * num) {
            WeakSelf.inputMoneyTextField.text = [WeakSelf.inputMoneyTextField.text stringByAppendingString:num];
        };
        //撤销回调
        customKeyboardView.RevocationCallBackBlock = ^{
            if (![WeakSelf.inputMoneyTextField.text isEqualToString:@"¥"]) {
                WeakSelf.inputMoneyTextField.text = [WeakSelf.inputMoneyTextField.text substringToIndex:WeakSelf.inputMoneyTextField.text.length - 1];
            }
        };
        //确认付款回调
        customKeyboardView.PayMoneyCallBackBlock = ^{
            [WeakSelf JumpToPayInterface];
        };
    }
    return _customKeyboardView;
}

@end
