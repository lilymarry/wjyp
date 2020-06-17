//
//  SUserAddAuth.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserAddAuth.h"

@implementation SUserAddAuth

- (void)sUserAddAuthSuccess:(SUserAddAuthSuccessBlock)success andFailure:(SUserAddAuthFailureBlock)failure {
    [HttpManager postUploadSingleImageWithUrl:SUserAddAuth_Url andImageName:_id_card_pic andKeyName:@"id_card_pic" andParameters:@{@"real_name":_real_name,@"id_card_num":_id_card_num} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
