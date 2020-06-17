//
//  SCartCartList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCartCartList.h"

@implementation SCartCartList

- (void)sCartCartListSuccess:(SCartCartListSuccessBlock)success andFailure:(SCartCartListFailureBlock)failure {
    [HttpManager postWithUrl:SCartCartList_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCartCartList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SCartCartList",@"goods":@"SCartCartList",@"goods_attr_first":@"SCartCartList",@"value_list":@"SCartCartList",@"first_list":@"SCartCartList",@"first_list_val":@"SCartCartList",@"first_val":@"SCartCartList"};
        }];
        success(dic[@"code"],dic[@"message"],[SCartCartList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
