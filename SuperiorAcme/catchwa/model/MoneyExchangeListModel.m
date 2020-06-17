//
//  ExchangeListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
// 获取银两充值列表

#import "MoneyExchangeListModel.h"

@implementation MoneyExchangeListModel
- (void)MoneyExchangeListModelSuccess:(MoneyExchangeListModelSuccessBlock)success andFailure:(MoneyExchangeListModelFailureBlock)failure
{
[HttpManager postSgiftWithUrl:@"Catcher/exchangeList" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    [MoneyExchangeListModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"list":@"MoneyExchangeListModel"};
    }];
    success(dic[@"code"],dic[@"message"],[MoneyExchangeListModel mj_objectWithKeyValues:dic]);
} andFail:^(NSError *error) {
    failure(error);
}];
    
}
- (void)MoneyExchangeModelSuccess:(MoneyExchangeModelSuccessBlock)success andFailure:(MoneyExchangeListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    

    if (SWNOTEmptyStr(self.coid)) {
        [para setValue:self.coid forKey:@"coid"];
    }
    
    if (SWNOTEmptyStr(self.pay_type)) {
        [para setValue:self.pay_type forKey:@"pay_type"];
    }
    [HttpManager postSgiftWithUrl:@"/Catcher/setOrder" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
