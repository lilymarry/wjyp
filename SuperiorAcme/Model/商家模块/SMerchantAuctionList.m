//
//  SMerchantAuctionList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantAuctionList.h"

@implementation SMerchantAuctionList

- (void)sMerchantAuctionListSuccess:(SMerchantAuctionListSuccessBlock)success andFailure:(SMerchantAuctionListFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantAuctionList_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantAuctionList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantAuctionList",@"goods_list":@"SMerchantAuctionList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantAuctionList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
