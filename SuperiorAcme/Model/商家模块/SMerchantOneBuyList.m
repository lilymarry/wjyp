//
//  SMerchantOneBuyList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantOneBuyList.h"

@implementation SMerchantOneBuyList

- (void)sMerchantOneBuyListSuccess:(SMerchantOneBuyListSuccessBlock)success andFailure:(SMerchantOneBuyListFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantOneBuyList_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantOneBuyList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantOneBuyList",@"goods_list":@"SMerchantOneBuyList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantOneBuyList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
