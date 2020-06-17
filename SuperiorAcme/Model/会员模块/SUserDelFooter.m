//
//  SUserDelFooter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserDelFooter.h"

@implementation SUserDelFooter

- (void)sUserDelFooterSuccess:(SUserDelFooterSuccessBlock)success andFailure:(SUserDelFooterFailureBlock)failure {
    [HttpManager postWithUrl:SUserDelFooter_Url andParameters:@{@"footer_ids":_footer_ids} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
