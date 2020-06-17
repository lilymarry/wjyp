//
//  SPreBuyPreBuyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreBuyPreBuyInfo.h"

@implementation SPreBuyPreBuyInfo

- (void)sPreBuyPreBuyInfoSuccess:(SPreBuyPreBuyInfoSuccessBlock)success andFailure:(SPreBuyPreBuyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SPreBuyPreBuyInfo_Url andParameters:@{@"pre_buy_id":_pre_buy_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SPreBuyPreBuyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SPreBuyPreBuyInfo",@"promotion":@"SPreBuyPreBuyInfo",@"ticketList":@"SPreBuyPreBuyInfo",@"goods_common_attr":@"SPreBuyPreBuyInfo",@"goodsAttr":@"SPreBuyPreBuyInfo",@"goods_banner":@"SPreBuyPreBuyInfo",@"attr_images":@"SPreBuyPreBuyInfo",@"product":@"SPreBuyPreBuyInfo",@"pictures":@"SPreBuyPreBuyInfo",@"goods_active":@"SPreBuyPreBuyInfo",@"dj_ticket":@"SPreBuyPreBuyInfo",@"goods_price_desc":@"SPreBuyPreBuyInfo",@"goods_server":@"SPreBuyPreBuyInfo",@"goods":@"SPreBuyPreBuyInfo",@"guess_goods_list":@"SPreBuyPreBuyInfo",@"goods_attr":@"SPreBuyPreBuyInfo",@"attr_list":@"SPreBuyPreBuyInfo",@"goods_attr_first":@"SPreBuyPreBuyInfo",@"value_list":@"SPreBuyPreBuyInfo",@"first_list":@"SPreBuyPreBuyInfo",@"first_list_val":@"SPreBuyPreBuyInfo",@"first_val":@"SPreBuyPreBuyInfo",@"list":@"SPreBuyPreBuyInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SPreBuyPreBuyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
