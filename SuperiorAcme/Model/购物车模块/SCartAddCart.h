//
//  SCartAddCart.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCartAddCartSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCartAddCartFailureBlock) (NSError * error);

@interface SCartAddCart : NSObject
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    17
@property (nonatomic, copy) NSString * product_id;//    货品id 可以为空    否    文本    未提供
@property (nonatomic, copy) NSString * num;//    数量

- (void)sCartAddCartSuccess:(SCartAddCartSuccessBlock)success andFailure:(SCartAddCartFailureBlock)failure;
@end
