//
//  SThemeThemeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SThemeThemeList.h"

@implementation SThemeThemeList

- (void)sThemeThemeListSuccess:(SThemeThemeListSuccessBlock)success andFailure:(SThemeThemeListFailureBlock)failure {
    [HttpManager postWithUrl:SThemeThemeList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SThemeThemeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SThemeThemeList"};
        }];
        success(dic[@"code"],dic[@"message"],[SThemeThemeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
