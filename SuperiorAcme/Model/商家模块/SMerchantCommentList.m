//
//  SMerchantCommentList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantCommentList.h"

@implementation SMerchantCommentList

- (void)sMerchantCommentListSuccess:(SMerchantCommentListSuccessBlock)success andFailure:(SMerchantCommentListFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantCommentList_Url andParameters:@{@"merchant_id":_merchant_id,@"goods_id":_goods_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantCommentList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SMerchantCommentList",@"pictures":@"SMerchantCommentList",@"reply_pictures_list":@"SMerchantCommentList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantCommentList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
