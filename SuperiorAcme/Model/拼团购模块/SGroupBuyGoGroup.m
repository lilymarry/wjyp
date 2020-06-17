//
//  SGroupBuyGoGroup.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyGoGroup.h"

@implementation SGroupBuyGoGroup

- (void)sGroupBuyGoGroupSuccess:(SGroupBuyGoGroupSuccessBlock)success andFailure:(SGroupBuyGoGroupFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyGoGroup_Url andParameters:@{@"log_id":_log_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyGoGroup mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"person":@"SGroupBuyGoGroup"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyGoGroup mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
