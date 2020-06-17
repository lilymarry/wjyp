//
//  SIntegralBuyIntegralBuyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyIntegralBuyInfo.h"

@implementation SIntegralBuyIntegralBuyInfo

- (void)sIntegralBuyIntegralBuyInfoSuccess:(SIntegralBuyIntegralBuyInfoSuccessBlock)success andFailure:(SIntegralBuyIntegralBuyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyIntegralBuyInfo_Url andParameters:@{@"integral_buy_id":_integral_buy_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralBuyIntegralBuyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SIntegralBuyIntegralBuyInfo",@"promotion":@"SIntegralBuyIntegralBuyInfo",@"ticketList":@"SIntegralBuyIntegralBuyInfo",@"goods_common_attr":@"SIntegralBuyIntegralBuyInfo",@"goodsAttr":@"SIntegralBuyIntegralBuyInfo",@"goods_banner":@"SIntegralBuyIntegralBuyInfo",@"attr_images":@"SIntegralBuyIntegralBuyInfo",@"product":@"SIntegralBuyIntegralBuyInfo",@"pictures":@"SIntegralBuyIntegralBuyInfo",@"goods_active":@"SIntegralBuyIntegralBuyInfo",@"dj_ticket":@"SIntegralBuyIntegralBuyInfo",@"goods_price_desc":@"SIntegralBuyIntegralBuyInfo",@"goods_server":@"SIntegralBuyIntegralBuyInfo",@"goods":@"SIntegralBuyIntegralBuyInfo",@"guess_goods_list":@"SIntegralBuyIntegralBuyInfo",@"goods_attr":@"SIntegralBuyIntegralBuyInfo",@"attr_list":@"SIntegralBuyIntegralBuyInfo",@"goods_attr_first":@"SIntegralBuyIntegralBuyInfo",@"value_list":@"SIntegralBuyIntegralBuyInfo",@"first_list":@"SIntegralBuyIntegralBuyInfo",@"first_list_val":@"SIntegralBuyIntegralBuyInfo",@"first_val":@"SIntegralBuyIntegralBuyInfo",@"list":@"SIntegralBuyIntegralBuyInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralBuyIntegralBuyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
