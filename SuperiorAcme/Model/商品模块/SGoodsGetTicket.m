//
//  SGoodsGetTicket.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsGetTicket.h"

@implementation SGoodsGetTicket

- (void)sGoodsGetTicketSuccess:(SGoodsGetTicketSuccessBlock)success andFailure:(SGoodsGetTicketFailureBlock)failure {
    [HttpManager postWithUrl:SGoodsGetTicket_Url andParameters:@{@"ticket_id":_ticket_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
