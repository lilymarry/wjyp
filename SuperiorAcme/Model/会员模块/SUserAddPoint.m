//
//  SUserAddPoint.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserAddPoint.h"

@implementation SUserAddPoint

- (void)sUserAddPointSuccess:(SUserAddPointSuccessBlock)success andFailure:(SUserAddPointFailureBlock)failure {
    [HttpManager postWithUrl:SUserAddPoint_Url andParameters:@{@"reason":_reason,@"get_point":_get_point} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
