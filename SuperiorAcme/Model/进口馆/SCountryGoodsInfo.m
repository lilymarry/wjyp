//
//  SCountryGoodsInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCountryGoodsInfo.h"

@implementation SCountryGoodsInfo

- (void)sCountryGoodsInfoSuccess:(SCountryGoodsInfoSuccessBlock)success andFailure:(SCountryGoodsInfoFailureBlock)failure {
    [HttpManager postWithUrl:SCountryGoodsInfo_Url andParameters:@{@"goods_id":_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCountryGoodsInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"promotion":@"SCountryGoodsInfo",@"ticketList":@"SCountryGoodsInfo",@"goods_common_attr":@"SCountryGoodsInfo",@"goodsAttr":@"SCountryGoodsInfo",@"goods_banner":@"SCountryGoodsInfo",@"attr_images":@"SCountryGoodsInfo",@"product":@"SCountryGoodsInfo",@"pictures":@"SCountryGoodsInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SCountryGoodsInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
