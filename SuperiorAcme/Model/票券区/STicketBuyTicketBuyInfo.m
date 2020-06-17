//
//  STicketBuyTicketBuyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "STicketBuyTicketBuyInfo.h"

@implementation STicketBuyTicketBuyInfo

- (void)sTicketBuyTicketBuyInfoSuccess:(STicketBuyTicketBuyInfoSuccessBlock)success andFailure:(STicketBuyTicketBuyInfoFailureBlock)failure {
    [HttpManager postWithUrl:STicketBuyTicketBuyInfo_Url andParameters:@{@"ticket_buy_id":_ticket_buy_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [STicketBuyTicketBuyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"promotion":@"STicketBuyTicketBuyInfo",@"ticketList":@"STicketBuyTicketBuyInfo",@"goods_common_attr":@"STicketBuyTicketBuyInfo",@"goodsAttr":@"STicketBuyTicketBuyInfo",@"goods_banner":@"STicketBuyTicketBuyInfo",@"attr_images":@"STicketBuyTicketBuyInfo",@"product":@"STicketBuyTicketBuyInfo",@"pictures":@"STicketBuyTicketBuyInfo",@"group":@"STicketBuyTicketBuyInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[STicketBuyTicketBuyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
