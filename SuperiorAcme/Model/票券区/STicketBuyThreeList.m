//
//  STicketBuyThreeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "STicketBuyThreeList.h"

@implementation STicketBuyThreeList

- (void)sTicketBuyThreeListSuccess:(STicketBuyThreeListSuccessBlock)success andFailure:(STicketBuyThreeListFailureBlock)failure {
    [HttpManager postWithUrl:STicketBuyThreeList_Url andParameters:@{@"two_cate_id":_two_cate_id,@"three_cate_id":_three_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [STicketBuyThreeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"three_cate_list":@"STicketBuyThreeList",@"ticket_buy_list":@"STicketBuyThreeList"};
        }];
        success(dic[@"code"],dic[@"message"],[STicketBuyThreeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
