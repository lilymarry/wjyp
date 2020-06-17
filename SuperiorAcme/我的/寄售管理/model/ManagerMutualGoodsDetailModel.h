//
//  ManagerMutualGoodsDetailModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ManagerMutualGoodsDetailModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^ManagerMutualGoodsDetailModelFailureBlock) (NSError * error);
@interface ManagerMutualGoodsDetailModel : NSObject
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, strong) ManagerMutualGoodsDetailModel* data;
@property (nonatomic, strong) ManagerMutualGoodsDetailModel* order_info;

@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *merchant_name;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSString *abs_url;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *order_type;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *order_price;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *merchant_id;
@property (nonatomic, strong) ManagerMutualGoodsDetailModel *param;
@property (nonatomic, copy) NSString *max_num;
@property (nonatomic, copy) NSString *cai_num;
@property (nonatomic, copy) NSString *surplus_num;
@property (nonatomic, copy) NSString *already_num;
@property (nonatomic, copy) NSString *index;

@property (nonatomic, strong) NSArray* goods_list;
@property (nonatomic, copy) NSString *goods_id;
//@property (nonatomic, copy) NSString *goods_name;
//@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *wholesale_price;
@property (nonatomic, copy) NSString *balance_rate;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *shop_price;
//@property (nonatomic, copy) NSString *abs_url;
@property (nonatomic, copy) NSString *profit;

@property (nonatomic, copy) NSString *consign_sale_num;
@property (nonatomic, copy) NSString *same_sale_num;
//@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *deal_num;
//@property (nonatomic, copy) NSString *surplus_num;
//@property (nonatomic, copy) NSString *already_num;
//@property (nonatomic, copy) NSString *index;

- (void)ManagerMutualGoodsDetailModelSuccess:(ManagerMutualGoodsDetailModelSuccessBlock)success andFailure:(ManagerMutualGoodsDetailModelFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
