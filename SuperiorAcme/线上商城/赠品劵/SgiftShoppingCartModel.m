//
//  SgiftSetOderModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftShoppingCartModel.h"

@implementation SgiftShoppingCartModel
- (void)SgiftShoppingCartModelSuccess:(SgiftShoppingCartModelSuccessBlock)success andFailure:(SgiftShoppingCartModelFailureBlock)failure{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.giftGoods_id)) {
        [para setValue:self.giftGoods_id forKey:@"giftGoods_id"];
    }
    
    if (SWNOTEmptyStr(self.num)) {
        [para setValue:self.num forKey:@"num"];
    }
    
    if (SWNOTEmptyStr(self.address_id)) {
        [para setValue:self.address_id forKey:@"address_id"];
    }
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/shoppingCart" baseurl:SgiftBase_url
       andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SgiftShoppingCartModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SgiftShoppingCartModel"};
        }];
        success(dic[@"code"],dic[@"message"],[SgiftShoppingCartModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
