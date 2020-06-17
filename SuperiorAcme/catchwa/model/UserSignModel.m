//
//  UserSignModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/26.
//  Copyright © 2019年 GYM. All rights reserved.
// 签到

#import "UserSignModel.h"

@implementation UserSignModel
- (void)UserSignModelSuccess:(UserSignModelSuccessBlock)success andFailure:(UserSignModelFailureBlock)failure
{
    
    [HttpManager postSgiftWithUrl:@"/Catcher/userSign" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        NSLog(@"sdddd %@",dic);
        success(dic[@"code"],dic[@"message"],[UserSignModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
