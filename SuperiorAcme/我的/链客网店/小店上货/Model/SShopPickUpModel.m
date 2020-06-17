//
//  SShopPickUpModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopPickUpModel.h"
#import "HttpManager.h"
#import <MJExtension.h>

@implementation SShopPickUpModel
-(void)GetShopPickUpGoodsListWith:(SShopPickUpModelSuccessBlock)success andFailure:(SShopPickUpModelFailureBlock)failure{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
      [SRegisterLogin shareInstance].method = @"GET";
    
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    
    if (SWNOTEmptyStr(self.name)) {
        [para setValue:self.name forKey:@"name"];
    }
    
    if (SWNOTEmptyStr(self.flag)) {
        [para setValue:self.flag forKey:@"flag"];
    }
    
    if (self.p >= 1) {
        [para setValue:@(self.p) forKey:@"p"];
    }
    NSLog(@"sdsd %@",para);
    [HttpManager getWithUrl:@"Distribution/goodsList" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SShopPickUpModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"top_nav":@"SShopPickUpModel",
                     @"two_cate_list":@"SShopPickUpModel",
                     @"list":@"SShopPickUpModel"};
        }];
        id data = dic[@"data"];
        data = [SShopPickUpModel mj_objectWithKeyValues:data];
        success(dic[@"code"],dic[@"message"],data,dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}


//上架商品
-(void)putawayGoodsMethod:(SShopPickUpModelSuccessBlock)success
               andFailure:(SShopPickUpModelFailureBlock)failure{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
     [SRegisterLogin shareInstance].method = @"POST";
    
    if (SWNOTEmptyStr(self.shop_id)) {
        [para setValue:self.shop_id forKey:@"shop_id"];
    }
    
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    
    if (SWNOTEmptyStr(self.product_id)) {
        [para setValue:self.product_id forKey:@"product_id"];
    }
    
    if (SWNOTEmptyStr(self.shop_goods_status)) {
        [para setValue:self.shop_goods_status forKey:@"shop_goods_status"];
    }
    
    if (SWNOTEmptyStr(self.is_special)) {
        [para setValue:self.is_special forKey:@"is_special"];
    }
    
    [HttpManager postWithUrl:@"Distribution/goods"
               andParameters:para
                  andSuccess:^(id Json) {
                      NSDictionary * dic = (NSDictionary *)Json;
                      id data = dic[@"data"];
                      success(dic[@"code"],dic[@"message"],data,dic[@"nums"]);
                  }
                     andFail:^(NSError *error) {
                        failure(error);
                     }];
    
    
}


@end
