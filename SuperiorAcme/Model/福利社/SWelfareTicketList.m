//
//  SWelfareTicketList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareTicketList.h"

@implementation SWelfareTicketList

- (void)sWelfareTicketListSuccess:(SWelfareTicketListSuccessBlock)success andFailure:(SWelfareTicketListFailureBlock)failure {
    [HttpManager postWithUrl:SWelfareTicketList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SWelfareTicketList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SWelfareTicketList",@"ticket_list":@"SWelfareTicketList"};
        }];
        success(dic[@"code"],dic[@"message"],[SWelfareTicketList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
