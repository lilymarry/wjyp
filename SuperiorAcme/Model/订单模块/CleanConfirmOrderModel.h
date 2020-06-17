//
//  CleanConfirmOrderModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/12.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CleanConfirmOrderModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^CleanConfirmOrderModelFailureBlock) (NSError * error);

@interface CleanConfirmOrderModel : NSObject
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * goods;
@property (nonatomic, strong) CleanConfirmOrderModel * data;
@property (nonatomic, strong) NSArray * item;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * is_active;
@property (nonatomic, copy) NSString * merchant_id;
@property (nonatomic, copy) NSString * merchant_name;
//@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * goods_num;
//@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * goods_img;
@property (nonatomic, copy) NSString * deadline;
@property (nonatomic, copy) NSString * expire_processing;
@property (nonatomic, copy) NSString * group;
@property (nonatomic, copy) NSString * crowd;
@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, copy) NSString * consign_sale_num;
@property (nonatomic, copy) NSString * same_sale_num;
@property (nonatomic, copy) NSString * service_charge_rate;
@property (nonatomic, copy) NSString * red_voucher_rate;
@property (nonatomic, copy) NSString * balance_rate;
//@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * order_type;
@property (nonatomic, copy) NSString * stock;
@property (nonatomic, copy) NSString * goods_attr_first;
//@property (nonatomic, copy) NSString * order_id;
//@property (nonatomic, copy) NSString * merchant_id;
//@property (nonatomic, copy) NSString * merchant_name;
@property (nonatomic, copy) NSString * sum_shop_price;
@property (nonatomic, copy) NSString * is_pay_password;
- (void)CleanConfirmOrderModelSuccess:(CleanConfirmOrderModelSuccessBlock)success andFailure:(CleanConfirmOrderModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
