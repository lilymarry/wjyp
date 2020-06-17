//
//  CleanMutualStateModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//
//clean_order_status 1寄售中 2已交易 3已提货 4已退款    否    文本    1
//order_status    clean_order_status = 2 1 待发货 2 待收货 3 已退款 4 已完成 clean_order_status = 3 1 待发货 2 待收货 3 已完成 clean_order_status = 4 1 退款中 2 已完成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef void(^CleanMutualStateModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^CleanMutualStateModelFailureBlock) (NSError * error);
@interface CleanMutualStateModel : NSObject
@property (nonatomic, copy) NSString * clean_order_status;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, strong) NSArray* data;
//clean_order_status == 1
@property (nonatomic, copy) NSString *clean_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_attr;
@property (nonatomic, copy) NSString *wholesale_price;
@property (nonatomic, copy) NSString *shop_price;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *profit;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *goods_img;


//clean_order_status != 1
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, copy) NSString *merchant_name;
@property (nonatomic, copy) NSString *pay_time;
//@property (nonatomic, copy) NSString *wholesale_price;
//@property (nonatomic, copy) NSString *goods_name;
//@property (nonatomic, copy) NSString *goods_attr;
@property (nonatomic, copy) NSString *order_price;
//@property (nonatomic, copy) NSString *profit;
//@property (nonatomic, copy) NSString *goods_num;
//@property (nonatomic, copy) NSString *goods_img;


- (void)CleanMutualStateModelSuccess:(CleanMutualStateModelSuccessBlock)success andFailure:(CleanMutualStateModelFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
