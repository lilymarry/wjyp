//
//  SGoodsGroupGoodsList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsGroupGoodsList.h"

@implementation SGoodsGroupGoodsList

- (void)sGoodsGroupGoodsListSuccess:(SGoodsGroupGoodsListSuccessBlock)success andFailure:(SGoodsGroupGoodsListFailureBlock)failure {
    [HttpManager postWithUrl:SGoodsGroupGoodsList_Url andParameters:@{@"goods_id":_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsGroupGoodsList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SGoodsGroupGoodsList",@"goods":@"SGoodsGroupGoodsList"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsGroupGoodsList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
