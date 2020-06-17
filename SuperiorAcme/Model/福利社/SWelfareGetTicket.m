//
//  SWelfareGetTicket.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareGetTicket.h"

@implementation SWelfareGetTicket

-(void)sWelfareGetTicketSuccess:(SWelfareGetTicketSuccessBlock)success andFailure:(SWelfareGetTicketFailureBlock)failure {
    [HttpManager postWithUrl:SWelfareGetTicket_Url andParameters:@{@"ticket_id":_ticket_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);

    }];
}
@end
