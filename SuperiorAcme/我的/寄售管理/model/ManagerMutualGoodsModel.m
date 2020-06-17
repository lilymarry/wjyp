//
//  ManagerMutualGoodsModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ManagerMutualGoodsModel.h"

@implementation ManagerMutualGoodsModel
- (void)ManagerMutualGoodsModelSuccess:(ManagerMutualGoodsModelSuccessBlock)success andFailure:(ManagerMutualGoodsModelFailureBlock)failure
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
        [ManagerMutualGoodsModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"ManagerMutualGoodsModel"};
        }];
        success(dic[@"code"],dic[@"message"],[ManagerMutualGoodsModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
