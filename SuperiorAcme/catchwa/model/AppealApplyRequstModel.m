//
//  AppealApplyRequstModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//  申诉接口

#import "AppealApplyRequstModel.h"

@implementation AppealApplyRequstModel
- (void)AppealApplyRequstModelSuccess:(AppealApplyRequstModelSuccessBlock)success andFailure:(AppealApplyRequstModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
 
    [HttpManager postSgiftWithUrl:@"Catcher/appeal" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
