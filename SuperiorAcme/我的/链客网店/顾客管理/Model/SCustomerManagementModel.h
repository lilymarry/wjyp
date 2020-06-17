//
//  SCustomerManagementModel.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MicroToolHeader.h"
#import "BaseModel.h"
@interface SCustomerManagementModel : BaseModel

/**
 顾客头像 / 店主头像
 */
@property (nonatomic, copy) NSString *head_path;

/**
 昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 暂时用这个金额 以后要改
 */
@property (nonatomic, copy) NSString *order_price;

/**
 日期对应
 */
@property (nonatomic, copy) NSString *deal_time;

/**
 级别
 */
@property (nonatomic, copy) NSString *set_name;

/**
 会员等级
 */
@property (nonatomic, copy) NSString *member_coding_html;

/**
 1 是开店订单 0 普通订单 （默认）
 */
@property (nonatomic, assign) BOOL is_open;

/**
 1 是专区商品（399区商品） 0 普通商品 （默认）
 */
@property (nonatomic, assign) BOOL is_special;

/**
1 是店主身份 0 普通顾客 （默认）
 */
@property (nonatomic, assign) BOOL is_has_shop;


//@property (nonatomic, copy) NSString * deal_time;
@property (nonatomic, copy) NSString * freight;

@property (nonatomic, copy) NSString * goods_num;
//@property (nonatomic, copy) NSString * head_path;

@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * id;


//@property (nonatomic, copy) NSString * is_has_shop;
//@property (nonatomic, copy) NSString * is_open;
//@property (nonatomic, copy) NSString * is_special;
@property (nonatomic, copy) NSString * member_coding;

//@property (nonatomic, copy) NSString * member_coding_html;
@property (nonatomic, copy) NSString * merchant_id;

//@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * order_goods_id;


@property (nonatomic, copy) NSString * order_id;

//@property (nonatomic, copy) NSString * order_price;


@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * other;
@property (nonatomic, copy) NSString * path;
@property (nonatomic, copy) NSString * pay_status;

@property (nonatomic, copy) NSString * pay_tickets;
@property (nonatomic, copy) NSString * pay_time;

@property (nonatomic, copy) NSString * pay_type;
@property (nonatomic, copy) NSString * profit_num;


//@property (nonatomic, copy) NSString * set_name;

@property (nonatomic, copy) NSString * shop_id;


@property (nonatomic, copy) NSString * shop_name;
@property (nonatomic, copy) NSString * supply_name;
@property (nonatomic, copy) NSString * ticket_color;
@property (nonatomic, copy) NSString * ticket_price;

@property (nonatomic, copy) NSString * ticket_status;
@property (nonatomic, copy) NSString * use_integral;

@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * is_balance;


//@property (nonatomic, copy) NSString * set_name;

//@property (nonatomic, copy) NSString * shop_id;

//@property (nonatomic, copy) NSString * is_special;
//
//
//@property (nonatomic, copy) NSString * member_coding;
//@property (nonatomic, copy) NSString * member_coding_html;
//@property (nonatomic, copy) NSString * merchant_id;
//@property (nonatomic, copy) NSString * order_goods_id;
//
//@property (nonatomic, copy) NSString * id;
//@property (nonatomic, copy) NSString * order_id;
//
//@property (nonatomic, copy) NSString * order_price;
//
//@property (nonatomic, copy) NSString * order_status;
//
//
//@property (nonatomic, copy) NSString * other;
//@property (nonatomic, copy) NSString * path;
//@property (nonatomic, copy) NSString * pay_status;
//@property (nonatomic, copy) NSString * pay_tickets;
//
//@property (nonatomic, copy) NSString * pay_time;
//@property (nonatomic, copy) NSString * pay_type;
//
//@property (nonatomic, copy) NSString * profit_num;
//
//@property (nonatomic, copy) NSString * set_name;
//@property (nonatomic, copy) NSString * shop_id;
//@property (nonatomic, copy) NSString * shop_name;

//@property (nonatomic, copy) NSString * supply_name;
//@property (nonatomic, copy) NSString * ticket_color;
//
//@property (nonatomic, copy) NSString * ticket_price;
//
//@property (nonatomic, copy) NSString * ticket_status;
//@property (nonatomic, copy) NSString * use_integral;
//
//@property (nonatomic, copy) NSString * user_id;






@end
