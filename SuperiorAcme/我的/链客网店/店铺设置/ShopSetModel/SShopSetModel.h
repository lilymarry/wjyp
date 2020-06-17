//
//  SShopSetModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SShopSetModelSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SShopSetModelFailureBlock) (NSError * error);

@interface SShopSetModel : NSObject

//更新店铺信息
+ (void)UpdateShopMessageWithDict:(NSDictionary *)shopMessageDict andSuccess:(SShopSetModelSuccessBlock)success andFailure:(SShopSetModelFailureBlock)failure;

@end
