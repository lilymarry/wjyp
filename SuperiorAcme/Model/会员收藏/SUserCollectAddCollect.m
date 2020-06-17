//
//  SUserCollectAddCollect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserCollectAddCollect.h"

@implementation SUserCollectAddCollect

- (void)sUserCollectAddCollectSuccess:(SUserCollectAddCollectSuccessBlock)success andFailure:(SUserCollectAddCollectFailureBlock)failure {
    [HttpManager postWithUrl:SUserCollectAddCollect_Url andParameters:@{@"type":_type,@"id_val":_id_val} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
