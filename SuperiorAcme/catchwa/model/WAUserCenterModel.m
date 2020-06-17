//
//  WAUserCenterModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
// 娃娃机个人中心

#import "WAUserCenterModel.h"

@implementation WAUserCenterModel


- (void)WAUserCenterModelSuccess:(WAUserCenterModelSuccessBlock)success andFailure:(WAUserCenterModelFailureBlock)failure{
    [HttpManager postSgiftWithUrl:@"Catcher/userCenter" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        WAUserCenterModel *model=[WAUserCenterModel mj_objectWithKeyValues:dic];
        
        success(dic[@"code"],dic[@"message"],model);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
@end
