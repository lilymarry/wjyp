//
//  SgiftShoppingSetOderModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftShoppingSetOderModel.h"

@implementation SgiftShoppingSetOderModel
- (void)SgiftShoppingSetOderSuccess:(SgiftShoppingSetOderModelSuccessBlock)success andFailure:(SgiftShoppingSetOderModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.address_id)) {
        [para setValue:self.address_id forKey:@"address_id"];
    }
    
    if (SWNOTEmptyStr(self.goods_num)) {
        [para setValue:self.goods_num forKey:@"goods_num"];
    }
    
    if (SWNOTEmptyStr(self.order_id)) {
        [para setValue:self.order_id forKey:@"order_id"];
    }
    if (SWNOTEmptyStr(self.goods)) {
        [para setValue:self.goods forKey:@"goods"];
    }
    
    if (SWNOTEmptyStr(self.leave_message)) {
        [para setValue:self.leave_message forKey:@"leave_message"];
    }
    
    if (SWNOTEmptyStr(self.invoice)) {
        [para setValue:self.invoice forKey:@"invoice"];
    }
    if (SWNOTEmptyStr(self.order_type)) {
        [para setValue:self.order_type forKey:@"order_type"];
    }
    
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/setOrder" baseurl:SgiftBase_url
                    andParameters:para andSuccess:^(id Json) {
                        NSDictionary * dic = (NSDictionary *)Json;
                        success(dic[@"code"],dic[@"message"],[SgiftShoppingSetOderModel mj_objectWithKeyValues:dic]);
                    } andFail:^(NSError *error) {
                        failure(error);
                    }];
}
@end
