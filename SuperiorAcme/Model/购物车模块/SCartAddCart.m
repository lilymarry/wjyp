//
//  SCartAddCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCartAddCart.h"

@implementation SCartAddCart

- (void)sCartAddCartSuccess:(SCartAddCartSuccessBlock)success andFailure:(SCartAddCartFailureBlock)failure {
    [HttpManager postWithUrl:SCartAddCart_Url andParameters:@{@"goods_id":_goods_id,@"product_id":_product_id == nil ? @"" : _product_id,@"num":_num} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
