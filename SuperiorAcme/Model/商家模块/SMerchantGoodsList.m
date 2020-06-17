//
//  SMerchantGoodsList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantGoodsList.h"

@implementation SMerchantGoodsList

- (void)sMerchantGoodsListSuccess:(SMerchantGoodsListSuccessBlock)success andFailure:(SMerchantGoodsListFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantGoodsList_Url andParameters:@{@"merchant_id":_merchant_id,@"is_hot":_is_hot,@"new_buy":_thisNew_buy,@"search_goods":_search_goods == nil ? @"" : _search_goods,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantGoodsList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantGoodsList",@"goods_list":@"SMerchantGoodsList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantGoodsList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
