//
//  SPay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPay.h"
#import "SPayChoice.h"
#import "SNPayManager.h"
#import "SPayGetAlipayParam.h"//获取支付宝支付参数
#import "SPayGetJsTine.h"//获取微信支付参数
#import "SPayFindPayResult.h"//订单支付查询

#import "SCarOrderAddOrder.h"//汽车购下单
#import "SCarOrderBalancePay.h"//汽车购余额支付
#import "SCarOrderIntegralPay.h"//汽车购积分支付

#import "SHouseOrderAddOrder.h"//房产购下单
#import "SHouseOrderBalancePay.h"//房产购余额支付
#import "SHouseOrderIntegralPay.h"//房产购积分支付

#import "SOrderSetOrder.h"//普通商品下单
#import "SGroupBuyOrderSetOrder.h"//拼单购下单
#import "SPreOrderPreSetOrder.h"//无界预购下单
#import "SLimitBuyOrderSetOrder.h"//限量购下单
#import "SIntegralOrderSetOrder.h"//积分抽奖下单
#import "SIntegralOrderDeleteOrder.h"//积分抽奖删除订单
#import "SAuctionOrderSetOrder.h"//比价购下单
#import "SIntegralBuyOrderSetOrder.h"//无界商店下单

#import "SBalancePayBalancePay.h"//余额支付
#import "SIntegralPayIntegralPay.h"//积分支付

#import "SOrderCenter_list.h"
#import "SPay_Pass.h"//余额支付、积分支付需要支付密码验证
#import "SModifyLoginPassword.h"
#import "SUserSetting.h"

#import "ExchangeSuccessView.h"
#import "SMemberOrder.h"

#import "SOrderCompleteController.h"  //线下支付成功后弹出页面
#import "SgiftShoppingSetOderModel.h"
#import "SgiftShoppingPayModel.h"
#import "SPayCoinPay.h"
@interface SPay ()
{
    NSString * model_order_id;//"2",//订单ID
    NSString * model_order_price;//"99",//订单金额
    NSString * model_balance;//: "33.59",//余额  没用到
    NSString * model_integral;//"0.00"//积分
    NSString * model_discount;//": "1",//是否可以使用红券 0不可使用  1可以使用
    NSString * model_yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
    NSString * model_blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
    NSString * model_discount_price;//红券金额
    NSString * model_yellow_price;//黄券金额
    NSString * model_blue_price;//蓝券金额
    
    NSString * payType;//1:余额 2:支付宝 3:微信 4:积分
    NSString * discount_type;//使用代金券：0不使用代金券 1使用红券 2使用黄券 3使用蓝券
    NSString * red_desc;//": ""//红券说明
    NSString * yellow_desc;//": ""//黄券说明
    NSString * blue_desc;//": ""//蓝券说明
    
    NSString *red_price;
    NSString *yellow_price;
    NSString *blue_price;
    
    BOOL payPass_isno;//余额支付、积分支付 是否密码验证
    
    BOOL pay_balance;
    
    NSString *model_ticket_info;
    NSString * model_ticket_price;
}


@property (strong, nonatomic) IBOutlet UIView *top_one;
@property (strong, nonatomic) IBOutlet UIButton *top_oneBtn;
@property (strong, nonatomic) IBOutlet UIView *top_two;
@property (strong, nonatomic) IBOutlet UIButton *top_twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIImageView *oneBtn_discount_negative2;
@property (strong, nonatomic) IBOutlet UIImageView *oneBtn_discount_negative1;
@property (strong, nonatomic) IBOutlet UIImageView *oneBtn_discount;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIImageView *twoBtn_discount_negative2;
@property (strong, nonatomic) IBOutlet UIImageView *twoBtn_discount_negative1;
@property (strong, nonatomic) IBOutlet UIImageView *twoBtn_discount;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *threeBtn_discount_negative2;
@property (strong, nonatomic) IBOutlet UIImageView *threeBtn_discount_negative1;
@property (strong, nonatomic) IBOutlet UIImageView *threeBtn_discount;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UILabel *mername;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mername_HHH;
@property (strong, nonatomic) IBOutlet UILabel *payMoney;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payMoney_HHH;
@property (strong, nonatomic) IBOutlet UILabel *balance;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UIView *integralView;

@property (weak, nonatomic) IBOutlet UIView *yueView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yueView_HHH;
@property (weak, nonatomic) IBOutlet UIView *zhifubaoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhifubaoView_HHH;
@property (weak, nonatomic) IBOutlet UIView *weixinView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *interContent;
@property (copy, nonatomic) NSString *ordersDoneType;//1:线上商城 2:拼团区 3:无界预购 4:竞拍汇 5:汽车购 6:房产购 7:爱心商店
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integralViewHHH;


/**
 兑换成功view
 */
@property (nonatomic, strong) ExchangeSuccessView *exchangeSuccessView;

//会员优惠
@property (weak, nonatomic) IBOutlet UILabel *price_descLab;
@property (weak, nonatomic) IBOutlet UILabel *lab_jifen;

@property (weak, nonatomic) IBOutlet UIView *SgiftView;

@property (weak, nonatomic) IBOutlet UILabel *SgiftLab;

@property (weak, nonatomic) IBOutlet UIButton *SgiftBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SgiftVewHHH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ticket_infoHHH;


@property (weak, nonatomic) IBOutlet UIView *yinliangView;
@property (weak, nonatomic) IBOutlet UILabel *yinliangLab;

@property (weak, nonatomic) IBOutlet UIButton *yinliangBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yinliangViewHHH;


@end

@implementation SPay

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //_ticket_info.hidden=YES;
   // _ticket_infoHHH.constant=0;
    
    if ([_model_type isEqualToString:@"汽车购"]) {
        _ordersDoneType = @"5";
    }
    if ([_model_type isEqualToString:@"房产购"]) {
        _ordersDoneType = @"6";
    }
    if ([_model_type isEqualToString:@"普通商品"]) {
        _ordersDoneType = @"1";
        if (_IsInShop) {         //399
            _ordersDoneType = @"12";
        }
        if (_IsSuiPian) {         //预留网页
            _ordersDoneType = @"16";
        }
    }
    if ([_model_type isEqualToString:@"拼单购"]) {
        _ordersDoneType = @"2";
    }
    if ([_model_type isEqualToString:@"无界预购"]) {
        _ordersDoneType = @"3";
    }
    if ([_model_type isEqualToString:@"无界商店"]) {
        _ordersDoneType = @"7";
    }
    if ([_model_type isEqualToString:@"线下商铺"]) {
        _ordersDoneType = @"9";
    }
    if ([_model_type isEqualToString:@"赠品专区"]) {
        _ordersDoneType = @"15";
    }
    [self createNav];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    payType = @"";//默认没有选择支付方式
    discount_type=  @"";
    
    _oneBtn_discount_negative2.hidden = YES;
    _oneBtn_discount_negative1.hidden = YES;
    _oneBtn_discount.hidden = YES;
    
    _twoBtn_discount_negative2.hidden = YES;
    _twoBtn_discount_negative1.hidden = YES;
    _twoBtn_discount.hidden = YES;
    
    _threeBtn_discount.hidden = YES;
    _threeBtn_discount_negative2.hidden = YES;
    _threeBtn_discount_negative1.hidden = YES;
    
    _SgiftVewHHH.constant=0;
    _SgiftView.hidden=YES;
    
    _yinliangView.hidden=YES;
    _yinliangViewHHH.constant=0;
    
    if (![WXApi isWXAppInstalled]) { //微信这里自动控制显示隐藏
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
    }
    
    if ([_model_type isEqualToString:@"汽车购"]) {
        
        
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _mername_HHH.constant = 0;
        _mername.hidden = YES;
        
        SCarOrderAddOrder * addOrder = [[SCarOrderAddOrder alloc] init];
        if (_order_id == nil) {
            //直接购买
            addOrder.car_id = _car_id;
            addOrder.num = _num;
            addOrder.order_id = @"";
        } else {
            //订单付款
            addOrder.car_id = @"";
            addOrder.num = @"";
            addOrder.order_id = _order_id;
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [addOrder sCarOrderAddOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SCarOrderAddOrder * addOrder = (SCarOrderAddOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                model_balance = addOrder.data.balance;
                model_integral = addOrder.data.integral;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                }
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else if ([_model_type isEqualToString:@"房产购"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _mername_HHH.constant = 0;
        _mername.hidden = YES;
        
        SHouseOrderAddOrder * addOrder = [[SHouseOrderAddOrder alloc] init];
        if (_order_id == nil) {
            //直接购买
            addOrder.style_id = _car_id;
            addOrder.num = _num;
            addOrder.order_id = @"";
        } else {
            //订单付款
            addOrder.style_id = @"";
            addOrder.num = @"";
            addOrder.order_id = _order_id;
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [addOrder sHouseOrderAddOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SHouseOrderAddOrder * addOrder = (SHouseOrderAddOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                model_balance = addOrder.data.balance;
                model_integral = addOrder.data.integral;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                     _integralViewHHH.constant = 0;
                }
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }else if ([_model_type isEqualToString:@"线下商铺"]){
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _integralView.hidden = NO;
        
        //sOfflineStoreSetOrderSuccess
        SOrderSetOrder * setOrder = [[SOrderSetOrder alloc] init];
        setOrder.order_id = _order_id;
        setOrder.pay_money   = _pay_money;
        setOrder.merchant_id = _merchant_id;
        setOrder.is_order_list = !_isPopRootVC;
        [setOrder sOfflineStoreSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            if ([code isEqualToString:@"1"]){
                SOrderSetOrder * addOrder = (SOrderSetOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
                //                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
              //是否能用余额支付  1可以  2不可以
              if (![addOrder.data.balance_status isEqualToString:@"1"]) {
                    _yueView.hidden=YES;
                    _yueView_HHH.constant = 0;
               }
                //是否能用积分支付  1可以  2不可以
                if (![addOrder.data.integration_status isEqualToString:@"1"]) {
                    _integralView.hidden = YES;
                    _integralViewHHH.constant = 0;
                }
            
                
//                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
//                    _integralView.hidden = YES;
//
//                }
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];
                NSLog(@"%@",addOrder.data.red_return_integral);
                if (addOrder.data.red_return_integral.length==0 ||[addOrder.data.red_return_integral intValue]==0) {
                       _lab_jifen.text=@"（赠送积分:0）";
                      _lab_jifen.hidden=YES;
                    
                }
                else
                {
                _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                }
                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
                model_discount_price = addOrder.data.red_price;
                model_yellow_price = addOrder.data.yellow_price;
                model_blue_price = addOrder.data.blue_price;
                _payMoney_HHH.constant = 0;//默认没有选代金券
                if(SWNOTEmptyStr(addOrder.data.price_desc)){
                    _price_descLab.text = addOrder.data.price_desc;
                }else{
                    _price_descLab.hidden = YES;
                }
            }else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    }else if ([_model_type isEqualToString:@"普通商品"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _integralView.hidden = YES;

        SOrderSetOrder * setOrder = [[SOrderSetOrder alloc] init];
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.order_type = [_model_type isEqualToString:@"普通商品"] ? @"0" : @"1";//0普通商品 1限量购
        setOrder.order_id = _order_id == nil ? @"" : _order_id;
        setOrder.collocation = @"";
        if ([_is_active isEqualToString:@"3"]) {
            setOrder.order_type =@"13";
        }
        if (_IsInShop) {
            setOrder.order_type =@"12";
        }
        if (_IsSuiPian) {
            setOrder.order_type =@"16";
        }
        if (_goods_Json != nil) {
            setOrder.collocation = _goods_Json;
            setOrder.order_type = @"4";
        }
        if (_invoice == nil) {
            setOrder.invoice = @
            "";
        } else {
            setOrder.invoice = _invoice;
        }
        if (_leave_message == nil) {
            setOrder.leave_message = @"";
        } else {
            setOrder.leave_message = _leave_message;
        }
        setOrder.goods = _goods;
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder sOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SOrderSetOrder * addOrder = (SOrderSetOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                model_ticket_price=addOrder.data.ticket_price;
                model_balance = addOrder.data.balance;
                if (addOrder.data.red_return_integral.length==0 ||[addOrder.data.red_return_integral doubleValue]==0) {
           
                     _lab_jifen.text=@"（赠送积分:0）";
                     _lab_jifen.hidden=YES;
                }
                else
                {
                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                    
                }
        //    if (_is399Norm) {
                  _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[addOrder.data.order_price doubleValue]-[addOrder.data.ticket_price doubleValue]];
           
                  model_ticket_info=addOrder.data.ticket_info;
                  _interContent.text = model_ticket_info;
         
//                }
//                else
//                {
//                     _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
//                }
                _mername.text = addOrder.data.merchant_name;
             
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                    _integralViewHHH.constant = 0;
                }
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];

                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
                model_discount_price = addOrder.data.discount_price;
                model_yellow_price = addOrder.data.yellow_price;
                model_blue_price = addOrder.data.blue_price;
                _payMoney_HHH.constant = 0;//默认没有选代金券
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;

            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else if ([_model_type isEqualToString:@"拼单购"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        SGroupBuyOrderSetOrder * setOrder = [[SGroupBuyOrderSetOrder alloc] init];
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.goods_num = _goods_num == nil ? @"" : _goods_num;
        setOrder.goods_id = _goods_id == nil ? @"" : _goods_id;
        setOrder.product_id = _product_id == nil ? @"" : _product_id;
        setOrder.order_type = _special_type_sub;
        setOrder.group_buy_id = _group_buy_id;
        setOrder.group_buy_order_id = _group_buy_order_id == nil ? @"" : _group_buy_order_id;
        setOrder.shipping_id = _shipping_id;
        if (_invoice == nil) {
            setOrder.invoice = @"";
        } else {
            setOrder.invoice = _invoice;
        }
        if (_leave_message == nil) {
            setOrder.leave_message = @"";
        } else {
            setOrder.leave_message = _leave_message;
        }
        if (_goods != nil && ![_goods isEqualToString:@""]) {
            NSData *data = [_goods dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *temp_dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            setOrder.freight = temp_dic[0][@"pay"];
            setOrder.freight_type = temp_dic[0][@"send_company"];
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder sGroupBuyOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SGroupBuyOrderSetOrder * addOrder = (SGroupBuyOrderSetOrder *)data;
                model_order_id = addOrder.data.group_buy_order_id;
                model_order_price = addOrder.data.order_price;
                model_balance = addOrder.data.balance;
                
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
                
                //判断隐藏哪些支付方式
                [self hidePayView: addOrder.data.order_price];
                if (addOrder.data.red_return_integral.length==0 ||[addOrder.data.red_return_integral intValue]==0) {
                    _lab_jifen.text=@"（赠送积分:0）";
                     _lab_jifen.hidden=YES;
                }
                else
                {
                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                }
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                    _integralViewHHH.constant = 0;
                }
                if ([addOrder.data.is_coin_pay isEqualToString:@"1"]) {
                    _yinliangViewHHH.constant=50;
                    _yinliangView.hidden=NO;
                    _yinliangLab.text=[NSString stringWithFormat:@"(银两:%@)",addOrder.data.chance_num];
                }
               
                
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];

                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
                model_discount_price = addOrder.data.discount_price;
                model_yellow_price = addOrder.data.yellow_price;
                model_blue_price = addOrder.data.blue_price;
                _payMoney_HHH.constant = 0;//默认没有选代金券
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_model_type isEqualToString:@"无界预购"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        SPreOrderPreSetOrder * setOrder = [[SPreOrderPreSetOrder alloc] init];
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.goods_num = _goods_num == nil ? @"" : _goods_num;
        setOrder.order_id = _order_id == nil ? @"" : _order_id;
        setOrder.pre_id = _pre_id == nil ? @"" : _pre_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder sPreOrderPreSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SPreOrderPreSetOrder * addOrder = (SPreOrderPreSetOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                model_balance = addOrder.data.balance;
                
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                    _integralViewHHH.constant = 0;
                }
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];

                if (addOrder.data.red_return_integral.length==0 ||[addOrder.data.red_return_integral intValue]==0) {
                    _lab_jifen.text=@"（赠送积分:0）";
                     _lab_jifen.hidden=YES;
                }
                else
                {
                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                }
                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_model_type isEqualToString:@"积分抽奖"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _zhifubaoView.hidden = YES;
        _zhifubaoView_HHH.constant = 0;
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
        SIntegralOrderSetOrder * setOrder = [[SIntegralOrderSetOrder alloc] init];
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.goods_num = _goods_num == nil ? @"" : _goods_num;
        setOrder.order_id = _order_id == nil ? @"" : _order_id;
        setOrder.integral_id = _integral_id == nil ? @"" : _integral_id;
        if (_add_integral_isno == NO) {
            setOrder.order_type = @"0";
        } else {
            //追加
            setOrder.order_type = @"1";
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder sIntegralOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SIntegralOrderSetOrder * addOrder = (SIntegralOrderSetOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                model_balance = addOrder.data.balance;
                
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                    _integralViewHHH.constant = 0;
                }
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];
                if (addOrder.data.red_return_integral.length==0||[addOrder.data.red_return_integral intValue]==0) {
                    _lab_jifen.text=@"（赠送积分:0）";
                     _lab_jifen.hidden=YES;
                }
                else
                {
                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                }
                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_model_type isEqualToString:@"比价购保证金"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _zhifubaoView.hidden = YES;
        _zhifubaoView_HHH.constant = 0;
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
        _integralView.hidden = YES;
        _mername.text = _base_merchant_name;
        model_order_id = _order_id;
        model_order_price = _base_money;
        _payMoney.text = [NSString stringWithFormat:@"￥%@",_base_money];
//        _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",_base_balance];
        _balance.text = [NSString stringWithFormat:@"（￥%@）",_base_balance];
        model_discount = @"0";
        model_yellow_discount = @"0";
        model_blue_discount = @"0";
    } else if ([_model_type isEqualToString:@"比价购"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        SAuctionOrderSetOrder * setOrder = [[SAuctionOrderSetOrder alloc] init];
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.auction_id = _auction_id == nil ? @"" : _auction_id;
        if (_auction_isno == NO) {
            setOrder.buy_type = @"1";
        } else {
            setOrder.buy_type = @"0";
        }
        setOrder.bid = @"";
        setOrder.order_id = _order_id == nil ? @"" : _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder sAuctionOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SAuctionOrderSetOrder * addOrder = (SAuctionOrderSetOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                model_balance = addOrder.data.balance;
                
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"￥%@",addOrder.data.order_price];
               
//                _balance.text = [NSString stringWithFormat:@"（余额:￥%@）",addOrder.data.balance];
                _balance.text = [NSString stringWithFormat:@"（￥%@）",addOrder.data.balance];
                if ([addOrder.data.is_integral isEqualToString:@"0"]) {
                    _integralView.hidden = YES;
                   
                    _integralViewHHH.constant = 0;
                }
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];
                if (addOrder.data.red_return_integral.length==0||[addOrder.data.red_return_integral intValue]==0) {
                    _lab_jifen.text=@"（赠送积分:0）";
                     _lab_jifen.hidden=YES;
                }
                else
                {
                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                }
                model_discount = addOrder.data.discount;
                model_yellow_discount = addOrder.data.yellow_discount;
                model_blue_discount = addOrder.data.blue_discount;
                red_desc = addOrder.data.red_desc;
                yellow_desc = addOrder.data.yellow_desc;
                blue_desc = addOrder.data.blue_desc;
                
                red_price = addOrder.data.red_price;
                yellow_price = addOrder.data.yellow_price;
                blue_price = addOrder.data.blue_price;
                
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_model_type isEqualToString:@"无界商店"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _yueView.hidden = YES;
        _yueView_HHH.constant = 0;
        _zhifubaoView.hidden = YES;
        _zhifubaoView_HHH.constant = 0;
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
        SIntegralBuyOrderSetOrder * setOrder = [[SIntegralBuyOrderSetOrder alloc] init];
        setOrder.integralBuy_id = _integralBuy_id == nil ? @"" : _integralBuy_id;
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.goods_num = _goods_num == nil ? @"" : _goods_num;
        setOrder.order_id = _order_id == nil ? @"" : _order_id;
        setOrder.shipping_id = _shipping_id;
        if (_invoice == nil) {
            setOrder.invoice = @"";
        } else {
            setOrder.invoice = _invoice;
        }
        if (_leave_message == nil) {
            setOrder.leave_message = @"";
        } else {
            setOrder.leave_message = _leave_message;
        }
        
        if (_goods != nil && ![_goods isEqualToString:@""]) {
            NSData *data = [_goods dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *temp_dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            setOrder.freight = temp_dic[0][@"pay"];
            setOrder.freight_type = temp_dic[0][@"send_company"];
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder sIntegralBuyOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SIntegralBuyOrderSetOrder * addOrder = (SIntegralBuyOrderSetOrder *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"%@积分",addOrder.data.order_price];
                _integral.text = [NSString stringWithFormat:@"（剩余积分:%@）",addOrder.data.integral];
                if (addOrder.data.red_return_integral.length==0||[addOrder.data.red_return_integral intValue]==0) {
                    _lab_jifen.text=@"（赠送积分:0）";
                     _lab_jifen.hidden=YES;
                }
                else
                {
                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
                }
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else if ([_model_type isEqualToString:@"赠品专区"]) {
        _top_one.hidden = YES;
        _top_two.hidden = YES;
        _yueView.hidden = YES;
        _yueView_HHH.constant = 0;
        _zhifubaoView.hidden = YES;
        _zhifubaoView_HHH.constant = 0;
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
        _integralView.hidden=YES;
        _integralViewHHH.constant=0;
        _SgiftView.hidden=NO;
        _SgiftVewHHH.constant=50;
        SgiftShoppingSetOderModel * setOrder = [[SgiftShoppingSetOderModel alloc] init];
        setOrder.address_id = _address_id == nil ? @"" : _address_id;
        setOrder.goods_num = _goods_num == nil ? @"" : _goods_num;
        setOrder.order_id = _order_id == nil ? @"" : _order_id;
        setOrder.order_type=@"15";
        if (_invoice == nil) {
            setOrder.invoice = @"";
        } else {
            setOrder.invoice = _invoice;
        }
        if (_leave_message == nil) {
            setOrder.leave_message = @"";
        } else {
            setOrder.leave_message = _leave_message;
        }
        setOrder.goods=_goods;
       // setOrder.invoice=_invoice;
     //   NSLog(@"ddfd %@",_goods);
//        if (_goods != nil && ![_goods isEqualToString:@""]) {
//            NSData *data = [_goods dataUsingEncoding:NSUTF8StringEncoding];
//            NSArray *temp_dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            NSLog(@"dfdsfds %@",temp_dic);
//            setOrder.freight = temp_dic[0][@"pay"];
//            setOrder.freight_type = temp_dic[0][@"send_company"];
    //    }
        [MBProgressHUD showMessage:nil toView:self.view];
        [setOrder SgiftShoppingSetOderSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SgiftShoppingSetOderModel * addOrder = (SgiftShoppingSetOderModel *)data;
                model_order_id = addOrder.data.order_id;
                model_order_price = addOrder.data.order_price;
                _mername.text = addOrder.data.merchant_name;
                _payMoney.text = [NSString stringWithFormat:@"%@赠品券",addOrder.data.order_price];
                
                _SgiftLab.text = [NSString stringWithFormat:@"（赠品券:%@）",addOrder.data.integral];
//                if (addOrder.data.red_return_integral.length==0) {
//                    _lab_jifen.text=@"（赠送积分:0）";
//                }
//                else
//                {
//                    _lab_jifen.text=[NSString stringWithFormat:@"（赠送积分:%@）",addOrder.data.red_return_integral];
//                }
                payType=@"5";
                [_SgiftBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else {
        if (_type == NO) {
            _top_one.hidden = YES;
            _top_two.hidden = YES;
        } else {
            //会员支付
            _top_one.hidden = NO;
            _top_two.hidden = NO;
            
            //默认传递使者
            [_top_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
            [_top_oneBtn addTarget:self action:@selector(top_oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [_top_twoBtn addTarget:self action:@selector(top_twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    //默认余额支付
//    [_threeBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_yinliangBtn addTarget:self action:@selector(fiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"支付";
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
    if ([_model_type isEqualToString:@"积分抽奖"]) {
        if (_add_integral_isno == NO) {
            SIntegralOrderDeleteOrder * del = [[SIntegralOrderDeleteOrder alloc] init];
            del.order_id = model_order_id;
            [del sIntegralOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
            
            } andFailure:^(NSError *error) {
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];

            }];
        }
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"放弃付款?" message:@"放弃后,可前往订单中心支付此订单" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 传递使者
- (void)top_oneBtnClick {
    [_top_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_top_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
}
#pragma mark - 传递大使
- (void)top_twoBtnClick {
    [_top_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_top_twoBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
}

#pragma mark - 没有代金券的情况处理

-(BOOL)isShowVC{
    BOOL isHaveRed = YES,isHaveYellow = YES,isHaveBlue = YES;
    if ([red_price isEqualToString:@"0"]){
        isHaveRed = NO;
    }
    if ([yellow_price isEqualToString:@"0"]){
        isHaveYellow = NO;
    }
    if ([blue_price isEqualToString:@"0"]){
        isHaveBlue = NO;
    }
    return (isHaveRed || isHaveYellow || isHaveBlue); //只有三种都是NO时 不弹框
}

-(BOOL)dealwithNotHaveDaijinQuan:(SPayChoice *)payChoice{
    BOOL isHaveRed = YES,isHaveYellow = YES,isHaveBlue = YES;
    if ([red_price isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
        isHaveRed = NO;
    }
    if ([yellow_price isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
        isHaveYellow = NO;
    }
    if ([blue_price isEqualToString:@"0"]) {
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
        isHaveBlue = NO;
    }
    
    return (isHaveRed || isHaveYellow || isHaveBlue);
}
#pragma mark - 余额支付
- (void)threeBtnClick {
    payType = @"1";
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
     [_yinliangBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    _oneBtn_discount_negative2.hidden = YES;
    _oneBtn_discount_negative1.hidden = YES;
    _oneBtn_discount.hidden = YES;
    
    _twoBtn_discount_negative2.hidden = YES;
    _twoBtn_discount_negative1.hidden = YES;
    _twoBtn_discount.hidden = YES;
    
    _threeBtn_discount.hidden = YES;
    _threeBtn_discount_negative2.hidden = YES;
    _threeBtn_discount_negative1.hidden = YES;
    discount_type = @"0";
    if ([model_discount isEqualToString:@"0"] && [model_yellow_discount isEqualToString:@"0"] && [model_blue_discount isEqualToString:@"0"]) {
        return;
    }
    
    if ([_is_active isEqualToString:@"3"]) {
        return;
    }
    if (![self isShowVC]) {
        return;
    }
    SPayChoice * payChoice = [[SPayChoice alloc] init];
    payChoice.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    payChoice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:payChoice animated:YES completion:nil];
//    if ([_model_type isEqualToString:@"普通商品"] || [_model_type isEqualToString:@"拼单购"]) {
//        [payChoice.notBtn setTitle:@"完成" forState:UIControlStateNormal];
//    }
    
    if(![self dealwithNotHaveDaijinQuan:payChoice]){
        payChoice = nil;
        return;
    }
    
    if ([model_discount isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
    }
    if ([model_yellow_discount isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
    }
    if ([model_blue_discount isEqualToString:@"0"]) {
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
        payChoice.bluBtn_HHH.constant = 0;
         payChoice.bluDes_HHH.constant = 0;
        
        
    }
    payChoice.red_des.text = red_desc;
    payChoice.yellow_des.text = yellow_desc;
    payChoice.blue_des.text = blue_desc;
    
    //单商品
    payChoice.SPayChoice_choice = ^(NSInteger num) {
        _oneBtn_discount.hidden = YES;
        _twoBtn_discount.hidden = YES;
        _threeBtn_discount.hidden = NO;
        CGFloat price = 0.0;
        if (num == 0) {
            _threeBtn_discount.image = [UIImage imageNamed:@"代金券红"];
            discount_type = @"1";
            _interContent.text = red_desc;
            _payMoney_HHH.constant = 35;
            price = [model_order_price floatValue] - [model_discount_price floatValue];
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f", price];
        } else if (num == 1) {
            _threeBtn_discount.image = [UIImage imageNamed:@"代金券黄"];
            discount_type = @"2";
            _interContent.text = yellow_desc;
            _payMoney_HHH.constant = 35;
             price = [model_order_price floatValue] - [model_yellow_price floatValue];
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f", price];
            
            
        } else if (num == 2) {
            _threeBtn_discount.image = [UIImage imageNamed:@"代金券蓝"];
            discount_type = @"3";
            _interContent.text = blue_desc;
            _payMoney_HHH.constant = 35;
            price = [model_order_price floatValue] - [model_blue_price floatValue];
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f", price];
        } else if (num == 3) {
            _threeBtn_discount.hidden = YES;
            discount_type = @"0";
            _payMoney_HHH.constant = 0;
      //      if (_is399Norm) {
                 _interContent.text = model_ticket_info;
                price = [model_order_price floatValue]- [model_ticket_price floatValue];;
                _payMoney.text = [NSString stringWithFormat:@"￥%.2f",price];
//            }
//            else
//            {
//                _interContent.text = @"";
//                price = [model_order_price floatValue];
//                _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
//            }
        }
        
        //判断隐藏哪些支付方式
        [self hidePayView: [NSString stringWithFormat:@"%.2f", price]];
    };

}
#pragma mark - 支付宝支付
- (void)twoBtnClick {
    payType = @"2";
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_yinliangBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    _oneBtn_discount_negative2.hidden = YES;
    _oneBtn_discount_negative1.hidden = YES;
    _oneBtn_discount.hidden = YES;
    
    _twoBtn_discount_negative2.hidden = YES;
    _twoBtn_discount_negative1.hidden = YES;
    _twoBtn_discount.hidden = YES;
    
    _threeBtn_discount.hidden = YES;
    _threeBtn_discount_negative2.hidden = YES;
    _threeBtn_discount_negative1.hidden = YES;
    discount_type = @"0";
    if ([model_discount isEqualToString:@"0"] && [model_yellow_discount isEqualToString:@"0"] && [model_blue_discount isEqualToString:@"0"]) {
        return;
    }
    
    if ([_is_active isEqualToString:@"3"]) {
        return;
    }
    
    if (![self isShowVC]) {
        return;
    }
    
    SPayChoice * payChoice = [[SPayChoice alloc] init];
    payChoice.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    payChoice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:payChoice animated:YES completion:nil];

    if(![self dealwithNotHaveDaijinQuan:payChoice]){
        payChoice = nil;
        return;
    }
    
    if ([model_discount isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
    }
    if ([model_yellow_discount isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
    }
    if ([model_blue_discount isEqualToString:@"0"]) {
      
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
        payChoice.bluBtn_HHH.constant = 0;
        payChoice.bluDes_HHH.constant = 0;
    }
    //单商品
    payChoice.red_des.text = red_desc;
    payChoice.yellow_des.text = yellow_desc;
    payChoice.blue_des.text = blue_desc;
    payChoice.SPayChoice_choice = ^(NSInteger num) {
        _oneBtn_discount.hidden = YES;
        _twoBtn_discount.hidden = NO;
        _threeBtn_discount.hidden = YES;
        if (num == 0) {
            _twoBtn_discount.image = [UIImage imageNamed:@"代金券红"];
            discount_type = @"1";
            _interContent.text = red_desc;
            _payMoney_HHH.constant = 35;
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue] - [model_discount_price floatValue]];
            
        } else if (num == 1) {
            _twoBtn_discount.image = [UIImage imageNamed:@"代金券黄"];
            discount_type = @"2";
            _interContent.text = yellow_desc;
            _payMoney_HHH.constant = 35;
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue] - [model_yellow_price floatValue]];
            
        } else if (num == 2) {
            _twoBtn_discount.image = [UIImage imageNamed:@"代金券蓝"];
            discount_type = @"3";
            _interContent.text = blue_desc;
            _payMoney_HHH.constant = 35;
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue] - [model_blue_price floatValue]];
        } else if (num == 3) {
            _twoBtn_discount.hidden = YES;
            discount_type = @"0";
         //   _interContent.text = @"";
            _payMoney_HHH.constant = 0;
          //  _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
            
            
//            _threeBtn_discount.hidden = YES;
//            discount_type = @"0";
//            _payMoney_HHH.constant = 0;
     //       if (_is399Norm) {
                _interContent.text = model_ticket_info;
                _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue]- [model_ticket_price floatValue]];
//            }
//            else
//            {
//                _interContent.text = @"";
//
//                _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
//            }
            
        }
    };

}
#pragma mark - 微信支付
- (void)oneBtnClick {
    payType = @"3";
    [_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_yinliangBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    _oneBtn_discount_negative2.hidden = YES;
    _oneBtn_discount_negative1.hidden = YES;
    _oneBtn_discount.hidden = YES;
    
    _twoBtn_discount_negative2.hidden = YES;
    _twoBtn_discount_negative1.hidden = YES;
    _twoBtn_discount.hidden = YES;
    
    _threeBtn_discount.hidden = YES;
    _threeBtn_discount_negative2.hidden = YES;
    _threeBtn_discount_negative1.hidden = YES;
    discount_type = @"0";
    if ([model_discount isEqualToString:@"0"] && [model_yellow_discount isEqualToString:@"0"] && [model_blue_discount isEqualToString:@"0"]) {
        return;
    }
    
    if ([_is_active isEqualToString:@"3"]) {
        return;
    }
    
    if (![self isShowVC]) {
        return;
    }
    
    SPayChoice * payChoice = [[SPayChoice alloc] init];
    payChoice.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    payChoice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:payChoice animated:YES completion:nil];
//    if ([_model_type isEqualToString:@"普通商品"] || [_model_type isEqualToString:@"拼单购"]) {
//        [payChoice.notBtn setTitle:@"完成" forState:UIControlStateNormal];
//    }
    
    if(![self dealwithNotHaveDaijinQuan:payChoice]){
        payChoice = nil;
        return;
    }
    
    if ([model_discount isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
    }
    if ([model_yellow_discount isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
    }
    if ([model_blue_discount isEqualToString:@"0"]) {
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
        payChoice.bluBtn_HHH.constant = 0;
        payChoice.bluDes_HHH.constant = 0;
    }
    payChoice.red_des.text = red_desc;
    payChoice.yellow_des.text = yellow_desc;
    payChoice.blue_des.text = blue_desc;
    //单商品
    payChoice.SPayChoice_choice = ^(NSInteger num) {
        _oneBtn_discount.hidden = NO;
        _twoBtn_discount.hidden = YES;
        _threeBtn_discount.hidden = YES;
        if (num == 0) {
            _oneBtn_discount.image = [UIImage imageNamed:@"代金券红"];
            discount_type = @"1";
            _interContent.text = red_desc;
            _payMoney_HHH.constant = 35;
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue] - [model_discount_price floatValue]];
            
        } else if (num == 1) {
            _oneBtn_discount.image = [UIImage imageNamed:@"代金券黄"];
            discount_type = @"2";
            _interContent.text = yellow_desc;
            _payMoney_HHH.constant = 35;
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue] - [model_yellow_price floatValue]];
            
        } else if (num == 2) {
            _oneBtn_discount.image = [UIImage imageNamed:@"代金券蓝"];
            discount_type = @"3";
            _interContent.text = blue_desc;
            _payMoney_HHH.constant = 35;
            _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue] - [model_blue_price floatValue]];
            
        } else if (num == 3) {
            _oneBtn_discount.hidden = YES;
            discount_type = @"0";
           // _interContent.text = @"";
            _payMoney_HHH.constant = 0;
           // _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
            
    //        if (_is399Norm) {
                _interContent.text = model_ticket_info;
                _payMoney.text = [NSString stringWithFormat:@"￥%.2f",[model_order_price floatValue]- [model_ticket_price floatValue]];
    //        }
//            else
//            {
//                _interContent.text = @"";
//
//                _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
//            }
            
            
        }
    };
}
#pragma mark - 积分支付
- (void)fourBtnClick {
    payType = @"4";
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
      [_yinliangBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    _oneBtn_discount_negative2.hidden = YES;
    _oneBtn_discount_negative1.hidden = YES;
    _oneBtn_discount.hidden = YES;
    
    _twoBtn_discount_negative2.hidden = YES;
    _twoBtn_discount_negative1.hidden = YES;
    _twoBtn_discount.hidden = YES;
    
    _threeBtn_discount.hidden = YES;
    _threeBtn_discount_negative2.hidden = YES;
    _threeBtn_discount_negative1.hidden = YES;
    discount_type = @"0";
   
    _interContent.text = @"";
    _payMoney_HHH.constant = 0;
    _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
}
-(void)fiveBtnClick
{
    payType = @"6";
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_yinliangBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    
    _oneBtn_discount_negative2.hidden = YES;
    _oneBtn_discount_negative1.hidden = YES;
    _oneBtn_discount.hidden = YES;
    
    _twoBtn_discount_negative2.hidden = YES;
    _twoBtn_discount_negative1.hidden = YES;
    _twoBtn_discount.hidden = YES;
    
    _threeBtn_discount.hidden = YES;
    _threeBtn_discount_negative2.hidden = YES;
    _threeBtn_discount_negative1.hidden = YES;
    discount_type = @"0";
    
    _interContent.text = @"";
    _payMoney_HHH.constant = 0;
    _payMoney.text = [NSString stringWithFormat:@"￥%@",model_order_price];
}
- (void)submitBtnClick {
    if ([payType isEqualToString:@""]) {
        [MBProgressHUD showError:@"请选择支付方式" toView:self.view];
        return;
    }
    if ([payType isEqualToString:@"2"]||[payType isEqualToString:@"3"]) {
         [self showTypeComing];
    }
  
    else
    {
    SUserSetting * set = [[SUserSetting alloc] init];
    [set sUserSettingSuccess:^(NSString *code, NSString *message, id data) {
        SUserSetting * set = (SUserSetting *)data;
        if ([set.data.is_pay_password integerValue] == 0) {
            [MBProgressHUD showError:@"请先设置支付密码" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            });
        } else {
            [self showTypeComing];
        }
    } andFailure:^(NSError *error) {
    }];
    }
}
- (void)showTypeComing {
    if ([payType isEqualToString:@"1"]) {
        //余额
        if (payPass_isno == NO) {
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                payPass_isno = YES;
                [self submitBtnClick];
            };
            pass.SPay_Pass_set = ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            };
            return;
        }
        payPass_isno = NO;
        
        if ([_model_type isEqualToString:@"汽车购"]) {
            SCarOrderBalancePay * pay = [[SCarOrderBalancePay alloc] init];
            pay.order_id = model_order_id;
            pay.discount_type = discount_type;
            [MBProgressHUD showMessage:nil toView:self.view];
            [pay sCarOrderBalancePaySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } else {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        } else if ([_model_type isEqualToString:@"房产购"]) {
            SHouseOrderBalancePay * pay = [[SHouseOrderBalancePay alloc] init];
            pay.order_id = model_order_id;
            pay.discount_type = discount_type;
            [MBProgressHUD showMessage:nil toView:self.view];
            [pay sHouseOrderBalancePaySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } else {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        } else {
            SBalancePayBalancePay * pay = [[SBalancePayBalancePay alloc] init];
            pay.order_id = model_order_id;
            pay.goods_num = @"";//只有积分追加的时候需要传个数
            if ([_model_type isEqualToString:@"普通商品"]) {
                pay.order_type = @"1";
                if ([_is_active isEqualToString:@"3"]) {         //预留网页
                     pay.order_type = @"13";
                }
                if (_IsInShop) {
                     pay.order_type = @"12";
                }
                if (_IsSuiPian) {
                    pay.order_type = @"16";
                }
            } else if ([_model_type isEqualToString:@"拼单购"]) {
                pay.order_type = @"2";
            } else if ([_model_type isEqualToString:@"无界预购"]) {
                pay.order_type = @"3";
            } else if ([_model_type isEqualToString:@"限量购"]) {
                pay.order_type = @"5";
            } else if ([_model_type isEqualToString:@"积分抽奖"]) {
                if (_add_integral_isno == NO) {
                    pay.order_type = @"6";
                } else {
                    pay.order_type = @"8";
                    pay.goods_num = _goods_num;
                }
            } else if ([_model_type isEqualToString:@"比价购保证金"]) {
                pay.order_type = @"7";
            } else if ([_model_type isEqualToString:@"比价购"]) {
                pay.order_type = @"4";
            }else if ([_model_type isEqualToString:@"线下商铺"]) {
                pay.order_type = @"9";
            }
            pay.discount_type = discount_type;
            [MBProgressHUD showMessage:nil toView:self.view];
            [pay sBalancePayBalancePaySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                                [self ubPayStatusToView];
                            }else{
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                        } else {
                            
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                                [self ubPayStatusToView];
                            }else{
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                               // list.Is_399=_is399;
                                [self.navigationController pushViewController:list animated:YES];
                                
                            }

                        } else {
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                                if (self.SPay_Back) {
                                    self.SPay_Back();
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_order_id == nil) {
                        if([_model_type isEqualToString:@"线下商铺"]){
                            [self ubPayStatusToView];
                        }else{
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                          //  list.Is_399=_is399;
                            [self.navigationController pushViewController:list animated:YES];
                        }
                    } else {
                        if (_IsSuiPianWeb) {
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                            [self.navigationController pushViewController:list animated:YES];
                        }
                        else
                        {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }
                });
            }];
        }
        
    } else if ([payType isEqualToString:@"4"]) {
        //积分支付
        if (payPass_isno == NO) {
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                payPass_isno = YES;
                [self submitBtnClick];
            };
            pass.SPay_Pass_set = ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            };
            return;
        }
        payPass_isno = NO;
        
        if ([_model_type isEqualToString:@"汽车购"]) {
            SCarOrderIntegralPay * pay = [[SCarOrderIntegralPay alloc] init];
            pay.order_id = model_order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [pay sCarOrderIntegralPaySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } else {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } else {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    });
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_order_id == nil) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } else {
                        if (self.SPay_Back) {
                            self.SPay_Back();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                });
            }];
        } else if ([_model_type isEqualToString:@"房产购"]) {
            SHouseOrderIntegralPay * pay = [[SHouseOrderIntegralPay alloc] init];
            pay.order_id = model_order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [pay sHouseOrderIntegralPaySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        } else {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        } else {
            SIntegralPayIntegralPay * integralPay = [[SIntegralPayIntegralPay alloc] init];
            integralPay.order_id = model_order_id;
            if ([_model_type isEqualToString:@"普通商品"]) {
                integralPay.order_type = @"1";
                if ([_is_active  isEqualToString:@"13"]) {         //预留网页
                    integralPay.order_type = @"13";
                }
                if (_IsInShop) {
                     integralPay.order_type = @"12";
                }
                if (_IsSuiPian) {
                    integralPay.order_type = @"16";
                }
            } else if ([_model_type isEqualToString:@"拼单购"]) {
                integralPay.order_type = @"2";
            } else if ([_model_type isEqualToString:@"无界预购"]) {
                integralPay.order_type = @"3";
            } else if ([_model_type isEqualToString:@"限量购"]) {
                integralPay.order_type = @"10";
            } else if ([_model_type isEqualToString:@"积分抽奖"]) {
                integralPay.order_type = @"6";
            } else if ([_model_type isEqualToString:@"比价购"]) {
                integralPay.order_type = @"4";
            } else if ([_model_type isEqualToString:@"积分抽奖"] && _add_integral_isno == YES) {
                integralPay.order_type = @"8";
            } else if ([_model_type isEqualToString:@"无界商店"]) {
                integralPay.order_type = @"5";
                self.exchangeSuccessView = [[ExchangeSuccessView alloc] initWithFrame:self.view.frame];
                [_exchangeSuccessView.checkOrders addTarget:self action:@selector(checkOrdersInfo) forControlEvents:UIControlEventTouchUpInside];
                [_exchangeSuccessView.backHome addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
            }else if ([_model_type isEqualToString:@"线下商铺"]){
                integralPay.order_type = @"9";
            }
            integralPay.auct_id = _auction_id == nil ? @"" : _auction_id;
            integralPay.goods_num = _goods_num == nil ? @"" : _goods_num;
            [MBProgressHUD showMessage:nil toView:self.view];
            [integralPay sIntegralPayIntegralPaySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    if ([_model_type isEqualToString:@"无界商店"]) {
                         //无界商店支付成功后弹出 
                         [[UIApplication sharedApplication].delegate.window addSubview:_exchangeSuccessView];
                    } else {
                        [MBProgressHUD showSuccess:message toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            if (_order_id == nil) {
                                if([_model_type isEqualToString:@"线下商铺"]){
                                    [self ubPayStatusToView];
                                }else{
                                    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                    list.type = _ordersDoneType;
                                    //list.Is_399=_is399;
                                    [self.navigationController pushViewController:list animated:YES];
                                }
                            } else {
                                if (_IsSuiPianWeb) {
                                    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                    list.type = _ordersDoneType;
                                    [self.navigationController pushViewController:list animated:YES];
                                }
                                else
                                {
                                    if (self.SPay_Back) {
                                        self.SPay_Back();
                                    }
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }
                        });
                    }
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                               [self ubPayStatusToView];
                            }else{
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                               // list.Is_399=_is399;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                        } else {
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                                if (self.SPay_Back) {
                                    self.SPay_Back();
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                }
                
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_order_id == nil) {
                        if([_model_type isEqualToString:@"线下商铺"]){
                            [self ubPayStatusToView];
                        }else{
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                           // list.Is_399=_is399;
                            [self.navigationController pushViewController:list animated:YES];
                    }
                    } else {
                        if (_IsSuiPianWeb) {
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                            [self.navigationController pushViewController:list animated:YES];
                        }
                        else
                        {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }
                });
            }];
        }
        
    } else if ([payType isEqualToString:@"2"]) {
        
        //支付宝
//        if (payPass_isno == NO) {
//            SPay_Pass * pass = [[SPay_Pass alloc] init];
//            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            [self.navigationController presentViewController:pass animated:YES completion:nil];
//            pass.SPay_Pass_back = ^{
//                payPass_isno = YES;
//                [self submitBtnClick];
//            };
//            pass.SPay_Pass_set = ^{
//                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
//                logPass.type = YES;
//                logPass.set_type = NO;
//                [self.navigationController pushViewController:logPass animated:YES];
//            };
//            return;
//        }
        payPass_isno = NO;
        
        SPayGetAlipayParam * getPay = [[SPayGetAlipayParam alloc] init];
        getPay.order_id = model_order_id;
        getPay.discount_type = discount_type;
        if ([_model_type isEqualToString:@"汽车购"]) {
            getPay.type = @"2";
        }
        if ([_model_type isEqualToString:@"房产购"]) {
            getPay.type = @"3";
        }
        if ([_model_type isEqualToString:@"普通商品"]) {
            getPay.type = @"4";
            if ([_is_active isEqualToString:@"3"]) {         //预留网页
                getPay.type = @"13";
            }
            if (_IsInShop) {
                   getPay.type = @"12";
            }
            if (_IsSuiPian) {
                 getPay.type = @"16";
            }
        }
        if ([_model_type isEqualToString:@"拼单购"]) {
            getPay.type = @"6";
        }
        if ([_model_type isEqualToString:@"无界预购"]) {
            getPay.type = @"5";
        }
        if ([_model_type isEqualToString:@"比价购"]) {
            getPay.type = @"8";
        }
        if ([_model_type isEqualToString:@"线下商铺"]) {
            getPay.type = @"9";
        }
        [MBProgressHUD showMessage:nil toView:self.view];
        [getPay sPayGetAlipayParamSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:self.view];
            
            SPayGetAlipayParam * getPay = (SPayGetAlipayParam *)data;
            [[SNPayManager sharePayManager] sn_openTheAlipayOrderString:getPay.data.pay_string WithServicePay:^(NSError *error) {
                if (error) {
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                                [self ubPayStatusToView];
                            }else{

                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                           
                                [self.navigationController pushViewController:list animated:YES];
                            }
                
                        } else {
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                                if (self.SPay_Back) {
                                    self.SPay_Back();
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                } else {
                            //支付结果查询
                    [self payShow];
                    }
              
            }];
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:self.view];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_order_id == nil) {
                    if([_model_type isEqualToString:@"线下商铺"]){
                       [self ubPayStatusToView];
                    }else{
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                       // list.Is_399=_is399;
                        [self.navigationController pushViewController:list animated:YES];
                        
                    }
                } else {
                    if (_IsSuiPianWeb) {
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                        [self.navigationController pushViewController:list animated:YES];
                    }
                    else
                    {
                        if (self.SPay_Back) {
                            self.SPay_Back();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            });
        }];
    } else if ([payType isEqualToString:@"3"]) {
        //微信支付
//        if (payPass_isno == NO) {
//            SPay_Pass * pass = [[SPay_Pass alloc] init];
//            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            [self.navigationController presentViewController:pass animated:YES completion:nil];
//            pass.SPay_Pass_back = ^{
//                payPass_isno = YES;
//                [self submitBtnClick];
//            };
//            pass.SPay_Pass_set = ^{
//                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
//                logPass.type = YES;
//                logPass.set_type = NO;
//                [self.navigationController pushViewController:logPass animated:YES];
//            };
//            return;
//        }
        payPass_isno = NO;
        
        SPayGetJsTine * tine = [[SPayGetJsTine alloc] init];
        tine.order_id = model_order_id;
        tine.discount_type = discount_type;
        if ([_model_type isEqualToString:@"汽车购"]) {
            tine.type = @"2";
        }
        if ([_model_type isEqualToString:@"房产购"]) {
            tine.type = @"3";
        }
        if ([_model_type isEqualToString:@"普通商品"]) {
            tine.type = @"4";
            if ([_is_active isEqualToString:@"3"]) {         //预留网页
                tine.type = @"13";
            }
            if (_IsInShop) {
                tine.type = @"12";
            }
            if (_IsSuiPian) {
                tine.type = @"16";
            }
        }
        if ([_model_type isEqualToString:@"拼单购"]) {
            tine.type = @"6";
        }
        if ([_model_type isEqualToString:@"无界预购"]) {
            tine.type = @"5";
        }
        if ([_model_type isEqualToString:@"比价购"]) {
            tine.type = @"8";
        }
        if ([_model_type isEqualToString:@"线下商铺"]) {
            tine.type = @"9";
        }
        
        tine.money = @"";
        [MBProgressHUD showMessage:nil toView:self.view];
        [tine sPayGetJsTineSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPayGetJsTine * tine = (SPayGetJsTine *)data;
            SNPayManager * manager = [SNPayManager sharePayManager];
            manager.wxPartnerId = tine.data.mch_id;//商户号
            manager.wxPrepayId = tine.data.prepay_id;//预支付id
            manager.wxNonceStr = tine.data.nonce_str;//随机字符串
            manager.wxTimeStamp = tine.data.time_stamp;//时间戳
            manager.wxSign = tine.data.sign;//签名
            [manager sn_openTheWechatWithServicePay:^(NSError *error) {
                if (error) {
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                                [self ubPayStatusToView];
                            }else{
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                              //  list.Is_399=_is399;
                                [self.navigationController pushViewController:list animated:YES];}
                        } else {
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                                if (self.SPay_Back) {
                                    self.SPay_Back();
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                } else {
                    //支付结果查询
                    [self payShow];
                }
            }];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_order_id == nil) {
                    if([_model_type isEqualToString:@"线下商铺"]){
                        [self ubPayStatusToView];
                    }else{

                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                       // list.Is_399=_is399;
                        [self.navigationController pushViewController:list animated:YES];}
                } else {
                    if (_IsSuiPianWeb) {
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                        [self.navigationController pushViewController:list animated:YES];
                    }
                    else
                    {
                        if (self.SPay_Back) {
                            self.SPay_Back();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            });
        }];
        
    }
    else if ([payType isEqualToString:@"5"])
    {
        // 赠品券支付
        if (payPass_isno == NO) {
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                payPass_isno = YES;
                [self submitBtnClick];
            };
            pass.SPay_Pass_set = ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            };
            return;
        }
        payPass_isno = NO;
        
   
            SgiftShoppingPayModel * integralPay = [[SgiftShoppingPayModel alloc] init];
            integralPay.order_id = model_order_id;
            integralPay.goods_num =_goods_num == nil ? @"" : _goods_num;;
           integralPay.order_type =@"15";
            [integralPay SgiftShoppingPayModelSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"200"]) {
                
                        [MBProgressHUD showSuccess:message toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                            [self.navigationController pushViewController:list animated:YES];
                            
                          
                        });
                   
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                       
                    });
                }
                
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                        if (self.SPay_Back) {
                            self.SPay_Back();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                  
                });
            }];
        }
     else if ([payType isEqualToString:@"6"])
    {
        // 银两支付
        if (payPass_isno == NO) {
            SPay_Pass * pass = [[SPay_Pass alloc] init];
            pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self.navigationController presentViewController:pass animated:YES completion:nil];
            pass.SPay_Pass_back = ^{
                payPass_isno = YES;
                [self submitBtnClick];
            };
            pass.SPay_Pass_set = ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            };
            return;
        }
        payPass_isno = NO;
        
        
        SPayCoinPay * integralPay = [[SPayCoinPay alloc] init];
        integralPay.order_id = model_order_id;
        
        integralPay.order_type =@"2";
        [integralPay SPayCoinPayPaySuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"200"]) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                                [self ubPayStatusToView];
                            }else{
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                        } else {
                            
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                                if (self.SPay_Back) {
                                    self.SPay_Back();
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_order_id == nil) {
                            if([_model_type isEqualToString:@"线下商铺"]){
                                [self ubPayStatusToView];
                            }else{
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                // list.Is_399=_is399;
                                [self.navigationController pushViewController:list animated:YES];
                                
                            }
                            
                        } else {
                            if (_IsSuiPianWeb) {
                                SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                                list.type = _ordersDoneType;
                                [self.navigationController pushViewController:list animated:YES];
                            }
                            else
                            {
                                if (self.SPay_Back) {
                                    self.SPay_Back();
                                }
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        }
                    });
                }
            } else {
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_order_id == nil) {
                        if([_model_type isEqualToString:@"线下商铺"]){
                            [self ubPayStatusToView];
                        }else{
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                            // list.Is_399=_is399;
                            [self.navigationController pushViewController:list animated:YES];
                            
                        }
                        
                    } else {
                        if (_IsSuiPianWeb) {
                            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                            list.type = _ordersDoneType;
                            [self.navigationController pushViewController:list animated:YES];
                        }
                        else
                        {
                            if (self.SPay_Back) {
                                self.SPay_Back();
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }
                });
            }
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_order_id == nil) {
                    if([_model_type isEqualToString:@"线下商铺"]){
                        [self ubPayStatusToView];
                    }else{
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                        // list.Is_399=_is399;
                        [self.navigationController pushViewController:list animated:YES];
                    }
                } else {
                    if (_IsSuiPianWeb) {
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                        [self.navigationController pushViewController:list animated:YES];
                    }
                    else
                    {
                        if (self.SPay_Back) {
                            self.SPay_Back();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            });
        }];
    }
}

#pragma mark - 线下支付成功/失败 跳转页面
-(void)ubPayStatusToView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //以前的 参考
//        if(self.isPopRootVC){
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"pushToMemberOrderVC" object:self];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }else{
//            [self.navigationController popViewControllerAnimated:YES];
//        }
        
        SOrderCompleteController *orderCompVC = [SOrderCompleteController new];
        orderCompVC.isPopRootVC = _isPopRootVC;
        orderCompVC.order_id = model_order_id;
        [self.navigationController pushViewController:orderCompVC animated:YES];
    });
}


#pragma mark - 支付结果查询
- (void)payShow {
    SPayFindPayResult * result = [[SPayFindPayResult alloc] init];
    result.order_id = model_order_id;
    if ([_model_type isEqualToString:@"汽车购"]) {
        result.type = @"2";
    }
    if ([_model_type isEqualToString:@"房产购"]) {
        result.type = @"3";
    }
    if ([_model_type isEqualToString:@"普通商品"]) {
        result.type = @"4";
//        if ([_is_active isEqualToString:@"3"]) {         //预留网页
//            result.type = @"13";
//        }
//        if (_IsInShop) {
//            result.type = @"12";
//        }
//        if (_IsSuiPian) {
//            result.type = @"16";
//        }
    }
    if ([_model_type isEqualToString:@"拼单购"]) {
        result.type = @"6";
    }
    if ([_model_type isEqualToString:@"无界预购"]) {
        result.type = @"5";
    }
    if ([_model_type isEqualToString:@"线下商铺"]) {
        result.type = @"9";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [result sPayFindPayResultSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        SPayFindPayResult * result = (SPayFindPayResult *)data;
        if ([result.data.status isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"支付成功" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_order_id == nil) {
                    if([_model_type isEqualToString:@"线下商铺"]){
                        [self ubPayStatusToView];
                    }else{
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                        [self.navigationController pushViewController:list animated:YES];
                    }
                } else {
                    if (self.SPay_Back) {
                        self.SPay_Back();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        } else {
            [MBProgressHUD showError:@"支付失败" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_order_id == nil) {
                    if([_model_type isEqualToString:@"线下商铺"]){
                        [self ubPayStatusToView];
                    }else{
                        SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                        list.type = _ordersDoneType;
                       // list.Is_399=_is399;
                        [self.navigationController pushViewController:list animated:YES];}
                } else {
                    if (self.SPay_Back) {
                        self.SPay_Back();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_order_id == nil) {
                if([_model_type isEqualToString:@"线下商铺"]){
                    [self ubPayStatusToView];
                }else{
                    SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
                    list.type = _ordersDoneType;
                    //list.Is_399=_is399;
                    [self.navigationController pushViewController:list animated:YES];
                }
            } else {
                if (self.SPay_Back) {
                    self.SPay_Back();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    }];

}


/**
 根据支付价格控制第三方支付控件是否隐藏

 @param price 最终支付价格
 */
- (void)hidePayView:(NSString *)price {
    if ([price doubleValue] <= 0.0) {
        _zhifubaoView.hidden = YES;
        _zhifubaoView_HHH.constant = 0;
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
    }
}

- (void)checkOrdersInfo {
    [_exchangeSuccessView removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_order_id == nil) {
            SOrderCenter_list * list = [[SOrderCenter_list alloc] init];
            list.type = _ordersDoneType;
            [self.navigationController pushViewController:list animated:YES];
        } else {
            if (self.SPay_Back) {
                self.SPay_Back();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
}

- (void)backHome {
    [_exchangeSuccessView removeFromSuperview];
    if (self.tabBarController.selectedIndex != 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        });
        self.tabBarController.selectedIndex = 0;
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
