//
//  SUserCollectDelOneCollect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserCollectDelOneCollect.h"

@implementation SUserCollectDelOneCollect

- (void)sUserCollectDelOneCollectSuccess:(SUserCollectDelOneCollectSuccessBlock)success andFailure:(SUserCollectDelOneCollectFailureBlock)failure {
    [HttpManager postWithUrl:SUserCollectDelOneCollect_Url andParameters:@{@"id_val":_id_val,@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
