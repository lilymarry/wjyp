//
//  SUserBalanceBalanceIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceBalanceIndexSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceBalanceIndexFailureBlock) (NSError * error);

@interface SUserBalanceBalanceIndex : NSObject

@property (nonatomic, strong) SUserBalanceBalanceIndex * data;
@property (nonatomic, copy) NSString * balance;//"会员余额"

- (void)sUserBalanceBalanceIndexSuccess:(SUserBalanceBalanceIndexSuccessBlock)success andFailure:(SUserBalanceBalanceIndexFailureBlock)failure;
@end
