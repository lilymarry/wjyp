//
//  SGroupBuyGroupBuyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyGroupBuyIndex.h"

@implementation SGroupBuyGroupBuyIndex

- (void)sGroupBuyGroupBuyIndexSuccess:(SGroupBuyGroupBuyIndexSuccessBlock)success andFailure:(SGroupBuyGroupBuyIndexFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyGroupBuyIndex_Url andParameters:@{@"cate_id":_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyGroupBuyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SGroupBuyGroupBuyIndex",@"two_cate_list":@"SGroupBuyGroupBuyIndex",@"group_buy_list":@"SGroupBuyGroupBuyIndex",@"append_person":@"SGroupBuyGroupBuyIndex",@"group_buy_msg":@"SGroupBuyGroupBuyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyGroupBuyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}


//体验拼单规则
/*
 status  0:不显示规则弹窗；1：显示规则弹窗  默认0  这里不填
 */
+ (void)sGroupBuyRuleSuccess:(SGroupBuyGroupBuyIndexSuccessBlock)success andFailure:(SGroupBuyGroupBuyIndexFailureBlock)failure{
    [HttpManager postWithUrl:@"GroupBuy/changeShowStatus"
               andParameters:@{}
                  andSuccess:^(id Json) {
                    NSDictionary * dic = (NSDictionary *)Json;
                    success(dic[@"code"],dic[@"message"],dic[@"data"],dic[@"nums"]);
                  } andFail:^(NSError *error) {
                    failure(error);
                  }];
}



@end
