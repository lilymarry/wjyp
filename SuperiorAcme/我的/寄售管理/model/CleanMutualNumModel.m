//
//  CleanMutualNumModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanMutualNumModel.h"

@implementation CleanMutualNumModel
- (void)CleanMutualNumModelSuccess:(CleanMutualNumModelSuccessBlock)success andFailure:(CleanMutualNumModelFailureBlock)failure
{
    [HttpManager postWithUrl:@"Clean/index" andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      
        success(dic[@"code"],dic[@"message"],[CleanMutualNumModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
