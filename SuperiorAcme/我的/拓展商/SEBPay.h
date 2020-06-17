//
//  SEBPay.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCarefreeGrade.h"

@interface SEBPay : UIViewController
@property (nonatomic, copy) NSString * type;//1:申请拓展商支付 2:无忧会员卡支付 3:无忧会员大礼包支付

@property (nonatomic, copy) NSString * rank_id;//会员卡id
@property (nonatomic, copy) NSString * member_coding;//会员卡编号
@property (nonatomic, copy) NSString * rank_name;//2:无忧会员卡支付 标题
@property (nonatomic, copy) NSString * money;
@property (nonatomic, copy) NSString * order_id;//订单重新支付所需

@property (nonatomic, strong) SCarefreeGrade * grade;//支付成功返回
@end
