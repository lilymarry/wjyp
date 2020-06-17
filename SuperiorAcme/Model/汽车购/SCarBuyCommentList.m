//
//  SCarBuyCommentList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarBuyCommentList.h"

@implementation SCarBuyCommentList

- (void)sCarBuyCommentListSuccess:(SCarBuyCommentListSuccessBlock)success andFailure:(SCarBuyCommentListFailureBlock)failure {
    [HttpManager postWithUrl:SCarBuyCommentList_Url andParameters:@{@"car_id":_car_id,@"label_id":_label_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCarBuyCommentList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"label_list":@"SCarBuyCommentList",@"comment_list":@"SCarBuyCommentList",@"pictures_arr":@"SCarBuyCommentList",@"label_arr":@"SCarBuyCommentList"};
        }];
        success(dic[@"code"],dic[@"message"],[SCarBuyCommentList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
