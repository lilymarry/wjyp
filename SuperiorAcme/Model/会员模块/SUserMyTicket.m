//
//  SUserMyTicket.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMyTicket.h"

@implementation SUserMyTicket

- (void)sUserMyTicketSuccess:(SUserMyTicketSuccessBlock)success andFailure:(SUserMyTicketFailureBlock)failure {
    [HttpManager postWithUrl:SUserMyTicket_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMyTicket mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"normal":@"SUserMyTicket",@"out":@"SUserMyTicket"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMyTicket mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
