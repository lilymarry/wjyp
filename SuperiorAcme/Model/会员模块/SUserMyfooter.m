//
//  SUserMyfooter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMyfooter.h"

@implementation SUserMyfooter

- (void)sUserMyfooterSuccess:(SUserMyfooterSuccessBlock)success andFailure:(SUserMyfooterFailureBlock)failure {
    [HttpManager postWithUrl:SUserMyfooter_Url andParameters:@{@"type":_type,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMyfooter mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMyfooter",@"goodsList":@"SUserMyfooter"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMyfooter mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

-(BOOL)isSearch{
    _isSearch = YES;
    return _isSearch;
}

@end
