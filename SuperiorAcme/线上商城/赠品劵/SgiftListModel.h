//
//  SgiftListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
typedef void(^SgiftListSuccessBlock) ( id data);
typedef void(^SgiftListFailureBlock) (NSError * error);
@interface SgiftListModel : BaseModel
@property (nonatomic, copy) NSString * p;//分页参数

//@property (nonatomic, copy) NSArray * gift_goods_list;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * goods_img;
@property (nonatomic, copy) NSString * country_id;
@property (nonatomic, copy) NSString * country_logo;
@property (nonatomic, copy) NSString * gift_goods_id;
@property (nonatomic, copy) NSString * use_voucher;
@property (nonatomic, copy) NSString * exchange_num;
@property (nonatomic, copy) NSString * shop_price;

@property (nonatomic, copy) NSString * active_type;
//@property (nonatomic, copy) NSString * country_id;
@property (nonatomic, copy) NSString * country_name;
@property (nonatomic, copy) NSString * g_integral;
@property (nonatomic, copy) NSString * goods_brief;
@property (nonatomic, copy) NSString * goods_gift;
//@property (nonatomic, copy) NSString * goods_id;
//@property (nonatomic, copy) NSString * goods_img;
//@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * integral;

@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * receive_name;
//@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * ticket_buy_discount;
@property (nonatomic, copy) NSString * ticket_buy_id;

@property (nonatomic, copy) SgiftListModel * data;
@property (nonatomic, copy) NSArray * gift_goods_list;
@property (nonatomic, copy) NSArray * distribution_list;
@property (nonatomic, copy) NSString * shop_id;






- (void)SgiftListSuccess:(SgiftListSuccessBlock)success andFailure:(SgiftListFailureBlock)failure;

@end
