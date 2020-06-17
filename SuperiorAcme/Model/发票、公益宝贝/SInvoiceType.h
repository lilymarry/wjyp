//
//  SInvoiceType.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SInvoiceTypeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SInvoiceTypeFailureBlock) (NSError * error);

@interface SInvoiceType : NSObject
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    1
@property (nonatomic, copy) NSString * invoice_type;//    发票类型id

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * list;//": "4"        //明细名


- (void)sInvoiceTypeSuccess:(SInvoiceTypeSuccessBlock)success andFailure:(SInvoiceTypeFailureBlock)failure;
@end
