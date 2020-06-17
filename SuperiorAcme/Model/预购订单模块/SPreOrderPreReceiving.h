//
//  SPreOrderPreReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreOrderPreReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SPreOrderPreReceivingFailureBlock) (NSError * error);

@interface SPreOrderPreReceiving : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sPreOrderPreReceivingSuccess:(SPreOrderPreReceivingSuccessBlock)success andFailure:(SPreOrderPreReceivingFailureBlock)failure;
@end
