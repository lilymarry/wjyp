//
//  SOrderConfirmInvoice.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderConfirmInvoice.h"
#import "AcceptCompanyVC.h"

@interface SOrderConfirmInvoice ()
{
    NSString * model_invoice_type;//发票种类名
    NSString * model_invoice_id;//发票id
    NSString * rise;//1->个人，2->公司
    NSString * is_invoice;//是否开发票（1->是，0->否
    NSString * model_t_id;//发票种类id
    NSString * model_express_fee;
    NSString * model_tax_pay;
    NSString * model_tax;
    NSString * model_explain;
    
}
@property (weak, nonatomic) IBOutlet UIButton *choiceInvBtn;
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *hid1View;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoView_HHH;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *sub_oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *sub_twoBtn;
@property (weak, nonatomic) IBOutlet UILabel *thisTax;
@property (weak, nonatomic) IBOutlet UILabel *thisExpress_fee;
@property (weak, nonatomic) IBOutlet UILabel *this_explain;
@property (weak, nonatomic) IBOutlet UITextField *listTF;
@property (weak, nonatomic) IBOutlet UITextField *riseTF;
@property (weak, nonatomic) IBOutlet UITextField *recognitionTF;
@end

@implementation SOrderConfirmInvoice

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _grayView.layer.masksToBounds = YES;
    _grayView.layer.cornerRadius = 3;
    
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.cornerRadius = 3;
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.layer.cornerRadius = 3;
    
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.borderColor = [UIColor redColor].CGColor;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.borderColor = WordColor_30.CGColor;
    
    [_oneBtn setImage:[UIImage imageNamed:@"发票选中"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];

    _twoView.hidden = YES;
    _threeView.hidden = YES;
    rise = @"1";//默认个人
    is_invoice = @"0";//默认不开发票
    [_sub_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_sub_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    _hid1View.hidden = YES;
    _grayView.hidden = YES;
    _twoView_HHH.constant = 140;
    
    
    if (_now_rise != nil) {
        _riseTF.text = _now_rise_name;
        _listTF.text = _now_invoice_detail;
        _recognitionTF.text = _now_recognition;
        if (_now_is_invoice == nil || [_now_is_invoice isEqualToString:@"0"]) {
            UIButton * btn = [[UIButton alloc] init];
            [self oneBtn:btn];
            [_twoBtn setTitle:@"请选择发票类型" forState:UIControlStateNormal];
        } else {
            [_twoBtn setTitle:_now_invoice_type forState:UIControlStateNormal];
            //下面显示状态
            is_invoice = @"1";//开发票
            
            _oneBtn.layer.borderWidth = 0.5;
            _oneBtn.layer.borderColor = WordColor_30.CGColor;
            _twoBtn.layer.borderWidth = 0.5;
            _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
            
            [_oneBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_twoBtn setImage:[UIImage imageNamed:@"发票选中"] forState:UIControlStateNormal];
            
            [_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
            [_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            _twoView.hidden = NO;
            _threeView.hidden = NO;
            //上面显示状态
            
            
            model_invoice_type = _now_invoice_type;
            model_invoice_id = _now_invoice_id;
            rise = _now_rise;
            is_invoice = _now_is_invoice;
            model_t_id = _now_t_id;
            model_express_fee = _now_express_fee;
            model_tax_pay = _now_tax_pay;
            model_tax = _now_tax;
            _thisTax.text = [NSString stringWithFormat:@"税金￥%@",_now_tax_pay];
            model_explain = _now_explain;
            _this_explain.text = _now_explain;
            _thisExpress_fee.text = [NSString stringWithFormat:@"您需要支付发票快递费%@元",_now_express_fee];

            if (_now_rise == nil || [_now_rise isEqualToString:@"1"]) {
                UIButton * btn = [[UIButton alloc] init];
                [self sub_oneBtn:btn];
            } else {
                UIButton * btn = [[UIButton alloc] init];
                [self sub_twoBtn:btn];
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
//    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"发票";
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
    
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rigthBtn setTitle:@"完成" forState:UIControlStateNormal];
    rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rigthBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rigthBtnClick {
    if ([is_invoice isEqualToString:@"1"] && [rise isEqualToString:@"1"]) {
        //个人
        if ([_riseTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入发票抬头" toView:self.view];
            return;
        }
        if ([_listTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择发票明细" toView:self.view];
            return;
        }
    }
    if ([is_invoice isEqualToString:@"1"] && [rise isEqualToString:@"2"]) {
        //公司
        if ([_riseTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入发票抬头" toView:self.view];
            return;
        }
        if ([_listTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请选择发票明细" toView:self.view];
            return;
        }
        if ([_recognitionTF.text isEqualToString:@""]) {
            [MBProgressHUD showError:@"请输入纳税人识别号" toView:self.view];
            return;
        }
    }
    if (self.SOrderConfirmInvoice_choice) {
        self.SOrderConfirmInvoice_choice(model_invoice_type,model_t_id, rise, _riseTF.text, _listTF.text, model_invoice_id, _recognitionTF.text, is_invoice, model_express_fee, model_tax_pay, model_tax, model_explain);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)oneBtn:(UIButton *)sender {
    is_invoice = @"0";//不开发票

    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.borderColor = [UIColor redColor].CGColor;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.borderColor = WordColor_30.CGColor;
    
    [_oneBtn setImage:[UIImage imageNamed:@"发票选中"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
    
    [_twoBtn setTitle:@"请选择发票类型" forState:UIControlStateNormal];
    
    _twoView.hidden = YES;
    _threeView.hidden = YES;
}
- (IBAction)twoBtn:(UIButton *)sender {
    is_invoice = @"1";//开发票
    
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.borderColor = WordColor_30.CGColor;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    [_oneBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"发票选中"] forState:UIControlStateNormal];
    
    [_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
    [_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _twoView.hidden = NO;
    _threeView.hidden = NO;
    
    AcceptCompanyVC * com = [[AcceptCompanyVC alloc] init];
    com.type = @"4";
    com.goods_id = _goods_id;
    com.num = _num;
    com.product_id = _product_id;
    
    /*
     *无界商店的商品发票价格的计算根据商品使用的积分计算
     */
    com.shop_Price = self.shop_Price;
    com.special_type = self.special_type;
    
    if ( [_twoBtn.titleLabel.text isEqualToString:@"请选择发票类型"]) {
        com.invoice_type_isno = NO;
    } else {
        com.invoice_type_isno = YES;
    }
    [self.navigationController pushViewController:com animated:YES];
    com.AcceptCompanyVC_invoice = ^(NSString *invoice_id, NSString *invoice_type, NSString *express_fee, NSString *tax, NSString *tax_pay, NSString * explain, NSString * t_id) {
        if ([invoice_id isEqualToString:@""]) {
            UIButton * btn;
            [self oneBtn:btn];
        } else {
            model_invoice_type = invoice_type;
            [_twoBtn setTitle:invoice_type forState:UIControlStateNormal];
            _thisTax.text = [NSString stringWithFormat:@"税金￥%@",tax_pay];
            _thisExpress_fee.text = [NSString stringWithFormat:@"您需要支付发票快递费%@元",express_fee];
            _this_explain.text = explain;
            model_invoice_id = invoice_id;
            model_t_id = t_id;
            model_express_fee = express_fee;
            model_tax_pay = tax_pay;
            model_tax = tax;
            model_explain = explain;
        }
        
    };
}
- (IBAction)sub_oneBtn:(UIButton *)sender {
    [_sub_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_sub_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    _hid1View.hidden = YES;
    _grayView.hidden = YES;
    _twoView_HHH.constant = 140;
    rise = @"1";
}
- (IBAction)sub_twoBtn:(UIButton *)sender {
    [_sub_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_sub_twoBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    _hid1View.hidden = NO;
    _grayView.hidden = NO;
    _twoView_HHH.constant = 290;
    rise = @"2";
}
- (IBAction)choiceInvBtn:(UIButton *)sender {
    AcceptCompanyVC * com = [[AcceptCompanyVC alloc] init];
    com.type = @"3";
    com.goods_id = _goods_id;
    com.t_id = model_t_id;
    [self.navigationController pushViewController:com animated:YES];
    com.AcceptCompanyVC_type = ^(NSString *list) {
        _listTF.text = list;
    };
}
@end
