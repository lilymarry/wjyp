//
//  SOfflineStoreOrderInforModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOfflineStoreOrderInforModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOfflineStoreOrderInforModelFailureBlock) (NSError * error);

@interface SOfflineStoreOrderInforModel : NSObject

/**
 订单id
 */
@property (nonatomic, copy) NSString * order_id;

/**
 订单的title
 */
@property (nonatomic, copy) NSString * order_name;

/**
 订单的subtitle
 */
@property (nonatomic, copy) NSString * order_value;


/**
 参数   5是取消订单 9是删除订单
 */
@property (nonatomic, copy) NSString *order_status;

- (void)sOfflineStoreOrderInfoSuccess:(SOfflineStoreOrderInforModelSuccessBlock)success andFailure:(SOfflineStoreOrderInforModelFailureBlock)failure;

//取消 删除订单
- (void)sOfflineStoreDelOrderSuccess:(SOfflineStoreOrderInforModelSuccessBlock)success andFailure:(SOfflineStoreOrderInforModelFailureBlock)failure;



@end
