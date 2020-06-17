//
//  SGroupBuyGroupBuyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyGroupBuyInfo.h"

@implementation SGroupBuyGroupBuyInfo

- (void)sGroupBuyGroupBuyInfoSuccess:(SGroupBuyGroupBuyInfoSuccessBlock)success andFailure:(SGroupBuyGroupBuyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyGroupBuyInfo_Url andParameters:@{@"group_buy_id":_group_buy_id, @"a_id":_a_id ? _a_id : @"", @"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyGroupBuyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SGroupBuyGroupBuyInfo",@"promotion":@"SGroupBuyGroupBuyInfo",@"ticketList":@"SGroupBuyGroupBuyInfo",@"goods_common_attr":@"SGroupBuyGroupBuyInfo",@"goodsAttr":@"SGroupBuyGroupBuyInfo",@"goods_banner":@"SGroupBuyGroupBuyInfo",@"attr_images":@"SGroupBuyGroupBuyInfo",@"product":@"SGroupBuyGroupBuyInfo",@"pictures":@"SGroupBuyGroupBuyInfo",@"group":@"SGroupBuyGroupBuyInfo",@"goods_active":@"SGroupBuyGroupBuyInfo",@"dj_ticket":@"SGroupBuyGroupBuyInfo",@"goods_price_desc":@"SGroupBuyGroupBuyInfo",@"goods_server":@"SGroupBuyGroupBuyInfo",@"goods":@"SGroupBuyGroupBuyInfo",@"guess_goods_list":@"SGroupBuyGroupBuyInfo",@"group":@"SGroupBuyGroupBuyInfo",@"goods_attr":@"SGroupBuyGroupBuyInfo",@"attr_list":@"SGroupBuyGroupBuyInfo",@"goods_attr_first":@"SGroupBuyGroupBuyInfo",@"value_list":@"SGroupBuyGroupBuyInfo",@"first_list":@"SGroupBuyGroupBuyInfo",@"first_list_val":@"SGroupBuyGroupBuyInfo",@"first_val":@"SGroupBuyGroupBuyInfo",@"list":@"SGroupBuyGroupBuyInfo",@"event_msg":@"SGroupBuyGroupBuyInfo",@"rank_list":@"SGroupBuyGroupBuyInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyGroupBuyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
