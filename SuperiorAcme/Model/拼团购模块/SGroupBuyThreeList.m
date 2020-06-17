//
//  SGroupBuyThreeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyThreeList.h"

@implementation SGroupBuyThreeList

- (void)sGroupBuyThreeListSuccess:(SGroupBuyThreeListSuccessBlock)success andFailure:(SGroupBuyThreeListFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyThreeList_Url andParameters:@{@"two_cate_id":_two_cate_id,@"three_cate_id":_three_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyThreeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"three_cate_list":@"SGroupBuyThreeList",@"group_buy_list":@"SGroupBuyThreeList",@"append_person":@"SGroupBuyThreeList"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyThreeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
