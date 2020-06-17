//
//  SGoodsGoodsInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsGoodsInfo.h"

@implementation SGoodsGoodsInfo

- (void)sGoodsGoodsInfoSuccess:(SGoodsGoodsInfoSuccessBlock)success andFailure:(SGoodsGoodsInfoFailureBlock)failure {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    
    if (SWNOTEmptyStr(self.order_id)) {
        [para setValue:self.order_id forKey:@"order_id"];
    }
    
    
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    
    if (SWNOTEmptyStr(self.product_id)) {
        [para setValue:self.product_id forKey:@"product_id"];
    }
    [HttpManager postWithUrl:SGoodsGoodsInfo_Url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGoodsGoodsInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SGoodsGoodsInfo",@"promotion":@"SGoodsGoodsInfo",@"ticketList":@"SGoodsGoodsInfo",@"goods_common_attr":@"SGoodsGoodsInfo",@"goodsAttr":@"SGoodsGoodsInfo",@"goods_banner":@"SGoodsGoodsInfo",@"attr_images":@"SGoodsGoodsInfo",@"product":@"SGoodsGoodsInfo",@"pictures":@"SGoodsGoodsInfo",@"goods_active":@"SGoodsGoodsInfo",@"dj_ticket":@"SGoodsGoodsInfo",@"goods_server":@"SGoodsGoodsInfo",@"goods":@"SGoodsGoodsInfo",@"guess_goods_list":@"SGoodsGoodsInfo",@"goods_price_desc":@"SGoodsGoodsInfo",@"goods_attr":@"SGoodsGoodsInfo",@"attr_list":@"SGoodsGoodsInfo",@"goods_attr_first":@"SGoodsGoodsInfo",@"value_list":@"SGoodsGoodsInfo",@"first_list":@"SGoodsGoodsInfo",@"first_list_val":@"SGoodsGoodsInfo",@"first_val":@"SGoodsGoodsInfo",@"list":@"SGoodsGoodsInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SGoodsGoodsInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
