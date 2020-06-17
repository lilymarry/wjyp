//
//  SCartEditCart.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCartEditCartSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCartEditCartFailureBlock) (NSError * error);

@interface SCartEditCart : NSObject
@property (nonatomic, copy) NSString * cart_json;//    购物车json格式[{"cart_id":"购物车ID","goods_id":"商品ID"，"product_id":"货品ID","num":"数量"}]

- (void)sCartEditCartSuccess:(SCartEditCartSuccessBlock)success andFailure:(SCartEditCartFailureBlock)failure;
@end
