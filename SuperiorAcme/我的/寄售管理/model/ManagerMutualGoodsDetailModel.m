//
//  ManagerMutualGoodsDetailModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ManagerMutualGoodsDetailModel.h"

@implementation ManagerMutualGoodsDetailModel
- (void)ManagerMutualGoodsDetailModelSuccess:(ManagerMutualGoodsDetailModelSuccessBlock)success andFailure:(ManagerMutualGoodsDetailModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    if (SWNOTEmptyStr(self.order_id)) {
        [para setValue:self.order_id forKey:@"order_id"];
    }
    
    [HttpManager postWithUrl:@"Clean/clean_order_list" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [ManagerMutualGoodsDetailModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_list":@"ManagerMutualGoodsDetailModel"};
        }];
        success(dic[@"code"],dic[@"message"],[ManagerMutualGoodsDetailModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
