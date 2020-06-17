//
//  SMerchantGroupList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantGroupList.h"

@implementation SMerchantGroupList

- (void)sMerchantGroupListSuccess:(SMerchantGroupListSuccessBlock)success andFailure:(SMerchantGroupListFailureBlock)failure {
//    [HttpManager postWithUrl:SMerchantGroupList_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {//旧代码,接口返回的数据不正确
    /*
     *使用新接口返回的数据
     *新街口 : SGroupBuyMerchantGroupBuyList_Url
     */
    [HttpManager postWithUrl:SGroupBuyMerchantGroupBuyList_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantGroupList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantGroupList",@"goods_list":@"SMerchantGroupList",@"append_person":@"SMerchantGroupList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantGroupList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
