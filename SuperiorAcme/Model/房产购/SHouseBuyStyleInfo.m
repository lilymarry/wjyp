//
//  SHouseBuyStyleInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseBuyStyleInfo.h"

@implementation SHouseBuyStyleInfo

- (void)sHouseBuyStyleInfoSuccess:(SHouseBuyStyleInfoSuccessBlock)success andFailure:(SHouseBuyStyleInfoFailureBlock)failure {
    [HttpManager postWithUrl:SHouseBuyStyleInfo_Url andParameters:@{@"style_id":_style_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SHouseBuyStyleInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"banner":@"SHouseBuyStyleInfo",@"other_style":@"SHouseBuyStyleInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SHouseBuyStyleInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
