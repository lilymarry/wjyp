//
//  SGoodsSearch.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsSearch.h"

@implementation SGoodsSearch

- (void)sGoodsSearchSuccess:(SGoodsSearchSuccessBlock)success andFailure:(SGoodsSearchFailureBlock)failure {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:_type forKey:@"type"];
    [para setValue:_name forKey:@"name"];
    [para setValue:_p forKey:@"p"];
    if (SWNOTEmptyStr(_searchType)) {
        [para setValue:@"1" forKey:_searchType];
    }
    if (SWNOTEmptyStr(_psort)) {
        [para setValue:_psort forKey:@"psort"];
    }
    if (SWNOTEmptyStr(_price)) {
        [para setValue:_price forKey:@"price"];
    }
    
    [HttpManager postWithUrl:SGoodsSearch_Url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsSearch mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SGoodsSearch",@"goodsList":@"SGoodsSearch"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsSearch mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
