//
//  SMemberOrderMess.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderMess.h"

@implementation SMemberOrderMess

- (void)sMemberOrderMessSuccess:(SMemberOrderMessSuccessBlock)success andFailure:(SMemberOrderMessFailureBlock)failure {
    [HttpManager getWithUrl:SMemberOrderMess_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMemberOrderMess mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SMemberOrderMess"};
        }];
        success(dic[@"code"],dic[@"message"],[SMemberOrderMess mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
