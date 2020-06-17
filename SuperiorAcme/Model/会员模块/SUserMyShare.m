//
//  SUserMyShare.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMyShare.h"

@implementation SUserMyShare

- (void)sUserMyShareSuccess:(SUserMyShareSuccessBlock)success andFailure:(SUserMyShareFailureBlock)failure {
    [HttpManager postWithUrl:SUserMyShare_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMyShare mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMyShare"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMyShare mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
