//
//  SCartEditCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCartEditCart.h"

@implementation SCartEditCart

- (void)sCartEditCartSuccess:(SCartEditCartSuccessBlock)success andFailure:(SCartEditCartFailureBlock)failure {
    [HttpManager postWithUrl:SCartEditCart_Url andParameters:@{@"cart_json":_cart_json} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
