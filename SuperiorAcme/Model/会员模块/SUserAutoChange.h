//
//  SUserAutoChange.h
//  SuperiorAcme
//
//  Created by GYM on 2018/4/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserAutoChangeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserAutoChangeFailureBlock) (NSError * error);

@interface SUserAutoChange : NSObject
@property (nonatomic, copy) NSString * integral;//    积分

@property (nonatomic, strong) SUserAutoChange * data;
@property (nonatomic, copy) NSString * integral_percentage;//":"10%(需扣除1积分综合服务费)"
@property (nonatomic, copy) NSString * desc;//":"描述"

- (void)sUserAutoChangeSuccess:(SUserAutoChangeSuccessBlock)success andFailure:(SUserAutoChangeFailureBlock)failure;
@end
