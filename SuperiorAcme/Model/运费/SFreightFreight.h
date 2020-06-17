//
//  SFreightFreight.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SFreightFreightSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SFreightFreightFailureBlock) (NSError * error);

@interface SFreightFreight : NSObject
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    5
@property (nonatomic, copy) NSString * address;//    地址(','分隔)
@property (nonatomic, copy) NSString * goods_num;//    商品数量
@property (nonatomic, copy) NSString * product_id;//    价格体系ID

@property (nonatomic, strong) SFreightFreight * data;
@property (nonatomic, copy) NSString * pay;//": "10"            //邮费说明

- (void)sFreightFreightSuccess:(SFreightFreightSuccessBlock)success andFailure:(SFreightFreightFailureBlock)failure;
@end
