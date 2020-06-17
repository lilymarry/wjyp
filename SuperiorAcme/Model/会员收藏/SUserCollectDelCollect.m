//
//  SUserCollectDelCollect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserCollectDelCollect.h"

@implementation SUserCollectDelCollect

- (void)sUserCollectDelCollectSuccess:(SUserCollectDelCollectSuccessBlock)success andFailure:(SUserCollectDelCollectFailureBlock)failure {
    [HttpManager postWithUrl:SUserCollectDelCollect_Url andParameters:@{@"collect_ids":_collect_ids} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
