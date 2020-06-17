//
//  SUserBalancePlatformAccount.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalancePlatformAccountSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalancePlatformAccountFailureBlock) (NSError * error);

@interface SUserBalancePlatformAccount : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "银行卡ID",
@property (nonatomic, copy) NSString * bank_num;//": "平台卡号",
@property (nonatomic, copy) NSString * open_bank;//": "平台开户行"
@property (nonatomic, copy) NSString * bank_name;//": "平台户名"

- (void)sUserBalancePlatformAccountSuccess:(SUserBalancePlatformAccountSuccessBlock)success andFailure:(SUserBalancePlatformAccountFailureBlock)failure;
@end
