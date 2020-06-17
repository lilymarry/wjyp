//
//  HeWaWaModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/3.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "HeWaWaModel.h"

@implementation HeWaWaModel
- (void)HeWaWaModelSuccess:(HeWaWaModelSuccessBlock)success andFailure:(HeWaWaModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];

    if (SWNOTEmptyStr(self.user_id)) {
        [para setValue:self.user_id forKey:@"user_id"];
    }
    [HttpManager postSgiftWithUrl:@"Catcher/heCatcher" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
          NSDictionary * dic = (NSDictionary *)Json;
        [HeWaWaModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"listDetails":@"HeWaWaModel",@"userDetails":@"HeWaWaModel"};
        }];
        success(dic[@"code"],dic[@"message"],[HeWaWaModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
