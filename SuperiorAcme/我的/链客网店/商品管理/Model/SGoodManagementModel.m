//
//  SGoodManagementModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGoodManagementModel.h"
#import "HttpManager.h"
#import <MJExtension.h>
@implementation SGoodManagementModel
//商品信息
-(void)putOnLineaGoodsMethod:(SGoodManagementModelSuccessBlock)success andFailure:(SGoodManagementFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [SRegisterLogin shareInstance].method = @"GET";
    
    if (SWNOTEmptyStr(self.shop_id)) {
        [para setValue:self.shop_id forKey:@"shop_id"];
    }
    
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    [HttpManager postWithUrl:@"Distribution/goods"
               andParameters:para
                  andSuccess:^(id Json) {
                      
                      NSDictionary * dic = (NSDictionary *)Json;
                        success(dic);
                      
                  }
                     andFail:^(NSError *error) {
                         failure(error);
                     }];
    
    
}
//商品上架/下架/删除接口
-(void)mangerLineaGoodsMethod:(SGoodManagementModelSuccessBlock)success andFailure:(SGoodManagementFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [SRegisterLogin shareInstance].method = @"PUT";
    
    if (SWNOTEmptyStr(self.shopidStr)) {
        [para setValue:self.shopidStr forKey:@"id"];
    }
    
    if (SWNOTEmptyStr(self.shop_goods_status)) {
        [para setValue:self.shop_goods_status forKey:@"shop_goods_status"];
    }
    if (SWNOTEmptyStr(self.shop_goods_rec)) {
        [para setValue:self.shop_goods_rec forKey:@"shop_goods_rec"];
    }
    
    NSLog(@"para %@",para);
    [HttpManager postWithUrl:@"Distribution/goods"
               andParameters:para
                  andSuccess:^(id Json) {
                      
                      NSDictionary * dic = (NSDictionary *)Json;
                      success(dic);
                      
                  }
                     andFail:^(NSError *error) {
                         failure(error);
                     }];
    
}
@end
