//
//  SWelfareFaceList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareFaceList.h"

@implementation SWelfareFaceList

- (void)sWelfareFaceListSuccess:(SWelfareFaceListSuccessBlock)success andFailure:(SWelfareFaceListFailureBlock)failure {
    [HttpManager postWithUrl:SWelfareFaceList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SWelfareFaceList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"announce":@"SWelfareFaceList",@"list":@"SWelfareFaceList"};
        }];
        success(dic[@"code"],dic[@"message"],[SWelfareFaceList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
