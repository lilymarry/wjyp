//
//  ExchangeGoodsModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/2.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ExchangeGoodsModelSuccessBlock) (NSString * code, NSString * message,id data);

typedef void(^ExchangeGoodsModelFailureBlock) (NSError * error);

@interface ExchangeGoodsModel : NSObject
@property(copy ,nonatomic)NSString *   cid ;
@property(copy ,nonatomic)NSString *   goods_id ;

- (void)ExchangeGoodsModelSuccess:(ExchangeGoodsModelSuccessBlock)success andFailure:(ExchangeGoodsModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
