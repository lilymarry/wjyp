//
//  SUserCollectCollectList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserCollectCollectList.h"

@implementation SUserCollectCollectList

- (void)sUserCollectCollectListSuccess:(SUserCollectCollectListSuccessBlock)success andFailure:(SUserCollectCollectListFailureBlock)failure {
    [HttpManager postWithUrl:SUserCollectCollectList_Url andParameters:@{@"type":_type,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserCollectCollectList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserCollectCollectList",@"goodsList":@"SUserCollectCollectList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserCollectCollectList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

-(BOOL)isSearch{
    _isSearch = YES;
    return _isSearch;
}
@end
