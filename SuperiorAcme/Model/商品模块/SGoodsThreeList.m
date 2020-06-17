//
//  SGoodsThreeList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsThreeList.h"

@implementation SGoodsThreeList

- (void)sGoodsThreeListSuccess:(SGoodsThreeListSuccessBlock)success andFailure:(SGoodsThreeListFailureBlock)failure {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setValue:_two_cate_id forKey:@"two_cate_id"];
    [para setValue:_three_cate_id forKey:@"three_cate_id"];
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
    if (SWNOTEmptyStr(_is_active)) {
        [para setValue:_is_active forKey:@"is_active"];
    }
    [HttpManager postWithUrl:SGoodsThreeList_Url
               andParameters:para
                  andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsThreeList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"three_cate_list":@"SGoodsThreeList",@"list":@"SGoodsThreeList"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsThreeList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
