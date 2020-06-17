//
//  SLimitBuyLimitBuyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyLimitBuyInfo.h"

@implementation SLimitBuyLimitBuyInfo

- (void)sLimitBuyLimitBuyInfoSuccess:(SLimitBuyLimitBuyInfoSuccessBlock)success andFailure:(SLimitBuyLimitBuyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyLimitBuyInfo_Url andParameters:@{@"limit_buy_id":_limit_buy_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SLimitBuyLimitBuyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SLimitBuyLimitBuyInfo",@"promotion":@"SLimitBuyLimitBuyInfo",@"ticketList":@"SLimitBuyLimitBuyInfo",@"goods_common_attr":@"SLimitBuyLimitBuyInfo",@"goodsAttr":@"SLimitBuyLimitBuyInfo",@"goods_banner":@"SLimitBuyLimitBuyInfo",@"attr_images":@"SLimitBuyLimitBuyInfo",@"product":@"SLimitBuyLimitBuyInfo",@"pictures":@"SLimitBuyLimitBuyInfo",@"goods_server":@"SLimitBuyLimitBuyInfo",@"cheap_group":@"SLimitBuyLimitBuyInfo",@"guess_goods_list":@"SLimitBuyLimitBuyInfo",@"dj_ticket":@"SLimitBuyLimitBuyInfo",@"goods_active":@"SLimitBuyLimitBuyInfo",@"goods_price_desc":@"SLimitBuyLimitBuyInfo",@"goods_attr":@"SLimitBuyLimitBuyInfo",@"attr_list":@"SLimitBuyLimitBuyInfo",@"goods_attr_first":@"SLimitBuyLimitBuyInfo",@"value_list":@"SLimitBuyLimitBuyInfo",@"first_list":@"SLimitBuyLimitBuyInfo",@"first_list_val":@"SLimitBuyLimitBuyInfo",@"first_val":@"SLimitBuyLimitBuyInfo",@"list":@"SLimitBuyLimitBuyInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SLimitBuyLimitBuyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
