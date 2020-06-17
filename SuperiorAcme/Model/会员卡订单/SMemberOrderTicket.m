//
//  SMemberOrderTicket.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderTicket.h"

@implementation SMemberOrderTicket

- (void)sMemberOrderTicketSuccess:(SMemberOrderTicketSuccessBlock)success andFailure:(SMemberOrderTicketFailureBlock)failure {
    [HttpManager postWithUrl:SMemberOrderTicket_Url andParameters:@{@"member_coding":_member_coding,@"number":_number} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SMemberOrderTicket mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
