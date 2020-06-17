//
//  SUserBalanceDelHjsInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceDelHjsInfoSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceDelHjsInfoFailureBlock) (NSError * error);

@interface SUserBalanceDelHjsInfo : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    1
@property (nonatomic, copy) NSString * order_status;//    订单状态 5取消 9删除

- (void)sUserBalanceDelHjsInfoSuccess:(SUserBalanceDelHjsInfoSuccessBlock)success andFailure:(SUserBalanceDelHjsInfoFailureBlock)failure;
@end
