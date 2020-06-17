//
//  ExchangeGoodsModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/2.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ExchangeGoodsModel.h"

@implementation ExchangeGoodsModel
- (void)ExchangeGoodsModelSuccess:(ExchangeGoodsModelSuccessBlock)success andFailure:(ExchangeGoodsModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.cid)) {
        [para setValue:self.cid forKey:@"cid"];
    }
    
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    [HttpManager postSgiftWithUrl:@"Catcher/exchangeCatchersGoodsOrder" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[ExchangeGoodsModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
