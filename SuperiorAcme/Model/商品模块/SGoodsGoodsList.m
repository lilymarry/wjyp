//
//  SGoodsGoodsList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsGoodsList.h"

@implementation SGoodsGoodsList

- (void)sGoodsGoodsListSuccess:(SGoodsGoodsListSuccessBlock)success andFailure:(SGoodsGoodsListFailureBlock)failure {
     NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    
    if (SWNOTEmptyStr(self.is_active)) {
        [para setValue:self.is_active forKey:@"is_active"];
    }
    
    [HttpManager postWithUrl:SGoodsGoodsList_Url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsGoodsList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SGoodsGoodsList",@"two_cate_list":@"SGoodsGoodsList",@"list":@"SGoodsGoodsList"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsGoodsList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
