//
//  SMerchantLimitList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantLimitList.h"

@implementation SMerchantLimitList

- (void)sMerchantLimitListSuccess:(SMerchantLimitListSuccessBlock)success andFailure:(SMerchantLimitListFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantLimitList_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantLimitList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantLimitList",@"goods_list":@"SMerchantLimitList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantLimitList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
