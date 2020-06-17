//
//  SThemeGoodsInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SThemeGoodsInfo.h"

@implementation SThemeGoodsInfo

- (void)sThemeGoodsInfoSuccess:(SThemeGoodsInfoSuccessBlock)success andFailure:(SThemeGoodsInfoFailureBlock)failure {
    [HttpManager postWithUrl:SThemeGoodsInfo_Url andParameters:@{@"goods_id":_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SThemeGoodsInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"promotion":@"SThemeGoodsInfo",@"ticketList":@"SThemeGoodsInfo",@"goods_common_attr":@"SThemeGoodsInfo",@"goodsAttr":@"SThemeGoodsInfo",@"goods_banner":@"SThemeGoodsInfo",@"attr_images":@"SThemeGoodsInfo",@"product":@"SThemeGoodsInfo",@"pictures":@"SThemeGoodsInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SThemeGoodsInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
