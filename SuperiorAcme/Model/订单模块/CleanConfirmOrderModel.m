//
//  CleanConfirmOrderModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/12.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanConfirmOrderModel.h"

@implementation CleanConfirmOrderModel

- (void)CleanConfirmOrderModelSuccess:(CleanConfirmOrderModelSuccessBlock)success andFailure:(CleanConfirmOrderModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.num)) {
        [para setValue:self.num forKey:@"num"];
    }
    
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    if (SWNOTEmptyStr(self.product_id)) {
        [para setValue:self.product_id forKey:@"product_id"];
    }
    
    if (SWNOTEmptyStr(self.order_id)) {
        [para setValue:self.order_id forKey:@"order_id"];
    }
    if (SWNOTEmptyStr(self.goods)) {
        [para setValue:self.goods forKey:@"goods"];
    }
    
   
[HttpManager postWithUrl:@"Order/cleanConfirm" andParameters:para andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    [CleanConfirmOrderModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"item":@"CleanConfirmOrderModel"};
    }];
    success(dic[@"code"],dic[@"message"],[CleanConfirmOrderModel mj_objectWithKeyValues:dic]);
} andFail:^(NSError *error) {
    failure(error);
}];
}
@end
