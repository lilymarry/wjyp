//
//  SOneBuyOneBuyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOneBuyOneBuyIndex.h"

@implementation SOneBuyOneBuyIndex

- (void)sOneBuyOneBuyIndexSuccess:(SOneBuyOneBuyIndexSuccessBlock)success andFailure:(SOneBuyOneBuyIndexFailureBlock)failure {
    [HttpManager postWithUrl:SOneBuyOneBuyIndex_Url andParameters:@{@"add_num":_add_num,@"person_num":_person_num,@"integral":_integral,@"is_hot":_is_hot,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOneBuyOneBuyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ads":@"SOneBuyOneBuyIndex",@"news":@"SOneBuyOneBuyIndex",@"oneBuyList":@"SOneBuyOneBuyIndex",@"rules":@"SOneBuyOneBuyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SOneBuyOneBuyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
