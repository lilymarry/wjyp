//
//  SAfterSaleShipping.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleShippingSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAfterSaleShippingFailureBlock) (NSError * error);

typedef void(^expressOrderSNSuccessBlock) (NSDictionary * dic);
typedef void(^expressOrderSNFailureBlock) (NSError * error);

@interface SAfterSaleShipping : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * shopping_id;//": "27;/",//快递id
@property (nonatomic, copy) NSString * shipping_name;//": "韵达快递"//快递名称

- (void)sAfterSaleShippingSuccess:(SAfterSaleShippingSuccessBlock)success andFailure:(SAfterSaleShippingFailureBlock)failure;

- (void)expressNamesFromOrderSN:(NSString *)orderSN success:(expressOrderSNSuccessBlock)success  failure:(expressOrderSNFailureBlock)failure;

@end
