//
//  CleanMutualStateModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanMutualStateModel.h"

@implementation CleanMutualStateModel
- (void)CleanMutualStateModelSuccess:(CleanMutualStateModelSuccessBlock)success andFailure:(CleanMutualStateModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.clean_order_status)) {
        [para setValue:self.clean_order_status forKey:@"clean_order_status"];
    }
    
    if (SWNOTEmptyStr(self.order_status)) {
        [para setValue:self.order_status forKey:@"order_status"];
    }
    
    [HttpManager postWithUrl:@"Clean/clean_goods_list" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
    [CleanMutualStateModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"CleanMutualStateModel"};
        }];
        success(dic[@"code"],dic[@"message"],[CleanMutualStateModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
