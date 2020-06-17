//
//  SUserShareBack.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserShareBack.h"

@implementation SUserShareBack

- (void)sUserShareBackSuccess:(SUserShareBackSuccessBlock)success andFailure:(SUserShareBackFailureBlock)failure {
    [HttpManager postWithUrl:SUserShareBack_Url andParameters:@{@"type":_type,@"content":_content == nil ? @"" : _content,@"id_val":_id_val,@"share_type":_share_type,@"url":_url} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
