//
//  STicketBuyTicketBuyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "STicketBuyTicketBuyIndex.h"

@implementation STicketBuyTicketBuyIndex

- (void)sTicketBuyTicketBuyIndexSuccess:(STicketBuyTicketBuyIndexSuccessBlock)success andFailure:(STicketBuyTicketBuyIndexFailureBlock)failure {
    [HttpManager postWithUrl:STicketBuyTicketBuyIndex_Url andParameters:@{@"cate_id":_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [STicketBuyTicketBuyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"STicketBuyTicketBuyIndex",@"two_cate_list":@"STicketBuyTicketBuyIndex",@"ticket_buy_list":@"STicketBuyTicketBuyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[STicketBuyTicketBuyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
