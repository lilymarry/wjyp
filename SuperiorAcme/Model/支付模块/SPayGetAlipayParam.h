//
//  SPayGetAlipayParam.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPayGetAlipayParamSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SPayGetAlipayParamFailureBlock) (NSError * error);

@interface SPayGetAlipayParam : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id    否    文本    1
@property (nonatomic, copy) NSString * discount_type;//    使用代金券：discount_type 0不使用代金券 1使用红券 2使用黄券 3使用蓝券    否    文本    0
@property (nonatomic, copy) NSString * type;//     类型：type 1.充值,2汽车购订单，3房产购 4 订单支付 5 预购 6拼单购 4限量购 8竞拍汇

@property (nonatomic, strong) SPayGetAlipayParam * data;
@property (nonatomic, copy) NSString * pay_string;//": "alipay_sdk=alipay-sdk-php-20161101&app_id=2016052801453164&biz_content=%7B%22body%22%3A%22APP%5Cu652f%5Cu4ed8%22%2C%22subject%22%3A%22APP%5Cu652f%5Cu4ed8%22%2C%22out_trade_no%22%3A%22151183956714065%22%2C%22timeout_express%22%3A%2260m%22%2C%22total_amount%22%3A%220.01%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay¬ify_url=http%3A%2F%2Fwjyp.txunda.com%2Findex.php%2FApi%2FPay%2FalipayNotify%2Ftype%2F2&sign_type=RSA×tamp=2017-11-28+12%3A58%3A22&version=1.0&sign=edjUtk5H%2BGjONUfKoY8L40TyCd71304MdoCW04hoooTcBjOmSeIUnARtvSQeeOytw3x7qnhXzXn2Ntr6mGU9fJ3gC9qOhDGd1cdO7NzfePz8LGOEniS%2Br3ZRK166f09WLwG1h%2BBeayTdpKh%2BmdwAmpYOhN43gFWolvDyFg5Xd6s%3D"

- (void)sPayGetAlipayParamSuccess:(SPayGetAlipayParamSuccessBlock)success andFailure:(SPayGetAlipayParamFailureBlock)failure;
@end
