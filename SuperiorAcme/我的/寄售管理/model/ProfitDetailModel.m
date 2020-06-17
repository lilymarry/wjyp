//
//  ProfitDetailModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ProfitDetailModel.h"

@implementation ProfitDetailModel
- (void)ProfitDetailModelModelSuccess:(ProfitDetailModelSuccessBlock)success andFailure:(ProfitDetailModelFailureBlock)failure
{
    [HttpManager postWithUrl:@"Clean/getRevenue" andParameters:@{@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
