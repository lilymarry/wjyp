//
//  SCartDelCart.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCartDelCartSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCartDelCartFailureBlock) (NSError * error);

@interface SCartDelCart : NSObject
@property (nonatomic, copy) NSString * cart_id_json;//    [{"cart_id":"购物车ID"}] json串

- (void)sCartDelCartSuccess:(SCartDelCartSuccessBlock)success andFailure:(SCartDelCartFailureBlock)failure;
@end
