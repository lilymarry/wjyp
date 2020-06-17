//
//  SGoodsAttrApi.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsAttrApi.h"

@implementation SGoodsAttrApi

- (void)sGoodsAttrApiSuccess:(SGoodsAttrApiSuccessBlock)success andFailure:(SGoodsAttrApiFailureBlock)failure {
    NSString *apiStr;
    NSString *baseUrl=Base_url;
    NSMutableDictionary *apiDit = [NSMutableDictionary dictionary];
    if (_buy_goods_type && [_buy_goods_type isEqualToString:@"拼单购"]) {
        apiStr = SGroupBuyGoodsAttrApi_Url;
        [apiDit setObject:_goods_id forKey:@"goods_id"];
        [apiDit setObject:_group_buy_type_status forKey:@"group_type"];
//        if ([_group_buy_type_status isEqualToString:@"1"]) {
//            [apiDit setObject:_product_id forKey:@"product_id"];
//        }
        
    } else if (_buy_goods_type && [_buy_goods_type isEqualToString:@"无界商店"]){
        /*
         *判断更改为"无界商店"的公共属性的接口地址
         */
        apiStr = SIntegralBuyAttrApi_Url;
        [apiDit setObject:_goods_id forKey:@"goods_id"];
        [apiDit setObject:_product_id forKey:@"product_id"];
    }
    else if (_buy_goods_type && [_buy_goods_type isEqualToString:@"赠品专区"]){
        apiStr = @"GiftGoods/attrApi";
        [apiDit setObject:_goods_id forKey:@"goods_id"];
        if (_product_id.length>0) {
             [apiDit setObject:_product_id forKey:@"product_id"];
        }
        baseUrl=SgiftBase_url;
       
    }
    else {
        apiStr = SGoodsAttrApi_Url;
        [apiDit setObject:_goods_id forKey:@"goods_id"];
        [apiDit setObject:_product_id forKey:@"product_id"];
    }
    [HttpManager postSgiftWithUrl:apiStr baseurl:baseUrl andParameters:apiDit
          andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsAttrApi mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"first_list":@"SGoodsAttrApi",@"first_list_val":@"SGoodsAttrApi",@"first_val":@"SGoodsAttrApi",@"dj_ticket":@"SGoodsAttrApi"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsAttrApi mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
