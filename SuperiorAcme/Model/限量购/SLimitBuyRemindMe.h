//
//  SLimitBuyRemindMe.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyRemindMeSuccessBlock) (NSString * code, NSString * message);
typedef void(^SLimitBuyRemindMeFailureBlock) (NSError * error);

@interface SLimitBuyRemindMe : NSObject
@property (nonatomic, copy) NSString * limit_buy_id;//限量购id

- (void)sLimitBuyRemindMeSuccess:(SLimitBuyRemindMeSuccessBlock)success andFailure:(SLimitBuyRemindMeFailureBlock)failure;
@end
