//
//  ManagerMutualGoodsModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ManagerMutualGoodsModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^ManagerMutualGoodsModelFailureBlock) (NSError * error);
@interface ManagerMutualGoodsModel : NSObject
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, strong) NSArray* data;
@property (nonatomic, copy) NSString * cp_id;
@property (nonatomic, copy) NSString * order_sn;
@property (nonatomic, copy) NSString * merchant_name;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * goods_attr;
@property (nonatomic, copy) NSString * abs_url;
@property (nonatomic, copy) NSString * goods_num;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * order_type;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * order_price;
@property (nonatomic, copy) NSString * merchant_id;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * shop_price;
@property (nonatomic, strong) ManagerMutualGoodsModel*param;
@property (nonatomic, copy) NSString *max_num;
@property (nonatomic, copy) NSString *cai_num;
@property (nonatomic, copy) NSString *surplus_num;
@property (nonatomic, copy) NSString *already_num;
@property (nonatomic, copy) NSString *index;

- (void)ManagerMutualGoodsModelSuccess:(ManagerMutualGoodsModelSuccessBlock)success andFailure:(ManagerMutualGoodsModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
