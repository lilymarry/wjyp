//
//  SUserBalanceHjsInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceHjsInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceHjsInfoFailureBlock) (NSError * error);

@interface SUserBalanceHjsInfo : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID;

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_name;//": "id",
@property (nonatomic, copy) NSString * order_value;//": "1"

- (void)sUserBalanceHjsInfoSuccess:(SUserBalanceHjsInfoSuccessBlock)success andFailure:(SUserBalanceHjsInfoFailureBlock)failure;
@end
