//
//  SPreBuyPreBuyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreBuyPreBuyIndex.h"

@implementation SPreBuyPreBuyIndex

- (void)sPreBuyPreBuyIndexSuccess:(SPreBuyPreBuyIndexSuccessBlock)success andFailure:(SPreBuyPreBuyIndexFailureBlock)failure {
    [HttpManager postWithUrl:SPreBuyPreBuyIndex_Url andParameters:@{@"cate_id":_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SPreBuyPreBuyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SPreBuyPreBuyIndex",@"two_cate_list":@"SPreBuyPreBuyIndex",@"pre_buy_list":@"SPreBuyPreBuyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SPreBuyPreBuyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
