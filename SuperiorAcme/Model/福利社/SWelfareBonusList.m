//
//  SWelfareBonusList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareBonusList.h"

@implementation SWelfareBonusList

- (void)sWelfareBonusListSuccess:(SWelfareBonusListSuccessBlock)success andFailure:(SWelfareBonusListFailureBlock)failure {
    [HttpManager postWithUrl:SWelfareBonusList_Url andParameters:@{@"bonus_id":_bonus_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SWelfareBonusList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ads_list":@"SWelfareBonusList"};
        }];
        success(dic[@"code"],dic[@"message"],[SWelfareBonusList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
