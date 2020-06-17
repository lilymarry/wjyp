//
//  SThemeThemeGoods.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SThemeThemeGoods.h"

@implementation SThemeThemeGoods

- (void)sThemeThemeGoodsSuccess:(SThemeThemeGoodsSuccessBlock)success andFailure:(SThemeThemeGoodsFailureBlock)failure {
    [HttpManager postWithUrl:SThemeThemeGoods_Url andParameters:@{@"theme_id":_theme_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SThemeThemeGoods mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SThemeThemeGoods"};
        }];
        success(dic[@"code"],dic[@"message"],[SThemeThemeGoods mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
