//
//  ApplyYellowModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
typedef void(^ApplyYellowModelSuccessBlock) (id result);
typedef void(^ApplyYellowModelFailureBlock) (NSError * error);

@interface ApplyYellowModel : BaseModel

@property (nonatomic, copy) NSString * shopid;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * p;


@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * all_num;
@property (nonatomic, copy) NSString * buyer;
@property (nonatomic, copy) NSString * freight;
@property (nonatomic, copy) NSString * goods_num;
@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * is_has_shop;
@property (nonatomic, copy) NSString * is_open;
@property (nonatomic, copy) NSString * is_pay_password;
@property (nonatomic, copy) NSString * is_special;
@property (nonatomic, copy) NSString * is_special_html;
@property (nonatomic, copy) NSString * member_coding;
@property (nonatomic, copy) NSString * merchant_id;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * order_goods_id;
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_price;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * order_time;
@property (nonatomic, copy) NSString * other;
@property (nonatomic, copy) NSString * path;
@property (nonatomic, copy) NSString * pay_status;
@property (nonatomic, copy) NSString * pay_tickets;
@property (nonatomic, copy) NSString * pay_time;
@property (nonatomic, copy) NSString * pay_type;
@property (nonatomic, copy) NSString * profit_num;
@property (nonatomic, copy) NSString * set_name;
@property (nonatomic, copy) NSString * shop_id;
@property (nonatomic, copy) NSString * shop_name;
@property (nonatomic, copy) NSString * shop_pic;
@property (nonatomic, copy) NSString * shop_pic_path;
@property (nonatomic, copy) NSString * shop_type;
@property (nonatomic, copy) NSString * supply_name;
@property (nonatomic, copy) NSString * ticket_color;
@property (nonatomic, copy) NSString * ticket_price;
@property (nonatomic, copy) NSString * ticket_lines;
@property (nonatomic, copy) NSString * ticket_status;
@property (nonatomic, copy) NSString * use_integral;
@property (nonatomic, copy) NSArray * order_goods;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * create_time;

//查看自己购买本店订单列表
-(void)ApplyYellowListMethod:(ApplyYellowModelSuccessBlock)success andFailure:(ApplyYellowModelFailureBlock)failure;

-(void)ShenHeYellowMethod:(ApplyYellowModelSuccessBlock)success andFailure:(ApplyYellowModelFailureBlock)failure;
@end
