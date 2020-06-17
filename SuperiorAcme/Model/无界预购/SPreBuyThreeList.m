//
//  SPreBuyThreeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreBuyThreeList.h"

@implementation SPreBuyThreeList

- (void)sPreBuyThreeListSuccess:(SPreBuyThreeListSuccessBlock)success andFailure:(SPreBuyThreeListFailureBlock)failure {
    [HttpManager postWithUrl:SPreBuyThreeList_Url andParameters:@{@"two_cate_id":_two_cate_id,@"three_cate_id":_three_cate_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SPreBuyThreeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"three_cate_list":@"SPreBuyThreeList",@"pre_buy_list":@"SPreBuyThreeList"};
        }];
        success(dic[@"code"],dic[@"message"],[SPreBuyThreeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
