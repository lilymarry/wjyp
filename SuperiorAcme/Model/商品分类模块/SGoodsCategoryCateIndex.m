//
//  SGoodsCategoryCateIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsCategoryCateIndex.h"

@implementation SGoodsCategoryCateIndex

- (void)sGoodsCategoryCateIndexSuccess:(SGoodsCategoryCateIndexSuccessBlock)success andFailure:(SGoodsCategoryCateIndexFailureBlock)failure {
    [HttpManager postWithUrl:SGoodsCategoryCateIndex_Url andParameters:@{@"cate_id":_cate_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsCategoryCateIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_cate":@"SGoodsCategoryCateIndex",@"two_cate":@"SGoodsCategoryCateIndex",@"host_brand":@"SGoodsCategoryCateIndex",@"three_cate":@"SGoodsCategoryCateIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsCategoryCateIndex mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
