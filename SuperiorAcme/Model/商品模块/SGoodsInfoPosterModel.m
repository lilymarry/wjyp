//
//  SGoodsInfoPosterModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGoodsInfoPosterModel.h"

@implementation SGoodsInfoPosterModel
- (void)sGoodsGoodsInfoSuccess:(SGoodsInfoPosterModelSuccessBlock)success andFailure:(SGoodsInfoPosterModelFailureBlock)failure
{
       NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    
    if (SWNOTEmptyStr(self.goods_img)) {
        [para setValue:self.goods_img forKey:@"goods_img"];
    }
    
    if (SWNOTEmptyStr(self.goods_name)) {
        [para setValue:self.goods_name forKey:@"goods_name"];
    }
    
    if (SWNOTEmptyStr(self.integral)) {
        [para setValue:self.integral forKey:@"integral"];
    }
    
    if (SWNOTEmptyStr(self.discount)) {
        [para setValue:self.discount forKey:@"discount"];
    }
    
    if (SWNOTEmptyStr(self.shop_price)) {
        [para setValue:self.shop_price forKey:@"shop_price"];
    }
    
    if (SWNOTEmptyStr(self.market_price)) {
        [para setValue:self.market_price forKey:@"market_price"];
    }
    if (SWNOTEmptyStr(self.shop_id)) {
        [para setValue:self.shop_id forKey:@"shop_id"];
    }
    if (SWNOTEmptyStr(self.invite_code)) {
        [para setValue:self.invite_code forKey:@"invite_code"];
    }
    if (SWNOTEmptyStr(self.is_active_5)) {
        [para setValue:self.is_active_5 forKey:@"is_active"];
    }
    [HttpManager postWithUrl:@"Index/poster" andParameters:para andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
   
    success(dic[@"code"],dic[@"message"],dic);
} andFail:^(NSError *error) {
    failure(error);
}];
}
@end
