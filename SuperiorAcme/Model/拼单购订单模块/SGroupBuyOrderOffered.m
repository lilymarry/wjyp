//
//  SGroupBuyOrderOffered.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderOffered.h"

@implementation SGroupBuyOrderOffered

- (void)sGroupBuyOrderOfferedSuccess:(SGroupBuyOrderOfferedSuccessBlock)success andFailure:(SGroupBuyOrderOfferedFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderOffered_Url andParameters:@{@"group_buy_order_id":_group_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyOrderOffered mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"head_pic":@"SGroupBuyOrderOffered",@"offered":@"SGroupBuyOrderOffered"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyOrderOffered mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
