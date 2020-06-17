//
//  SOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderSetOrder.h"

#define kOfflineStoreSetOrder_url @"OfflineStore/setOrder"

@implementation SOrderSetOrder

- (void)sOrderSetOrderSuccess:(SOrderSetOrderSuccessBlock)success andFailure:(SOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SOrderSetOrder_Url andParameters:@{@"address_id":_address_id,@"order_type":_order_type,@"order_id":_order_id,@"collocation":_collocation,@"invoice":_invoice,@"leave_message":_leave_message,@"goods":_goods == nil ? @"" : _goods} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}


- (void)sOfflineStoreSetOrderSuccess:(SOrderSetOrderSuccessBlock)success andFailure:(SOrderSetOrderFailureBlock)failure{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (self.is_order_list) {
        [para setValue:_order_id forKey:@"order_id"];
    }else{
        [para setValue:_merchant_id forKey:@"merchant_id"];
        [para setValue:_pay_money forKey:@"pay_money"];
    }
    
    [HttpManager postWithUrl:kOfflineStoreSetOrder_url
               andParameters:para
                  andSuccess:^(id Json) {
                      NSDictionary * dic = (NSDictionary *)Json;
                      success(dic[@"code"],dic[@"message"],[SOrderSetOrder mj_objectWithKeyValues:dic]);
                  }
                     andFail:^(NSError *error) {
                        failure(error);
                     }];
}



@end
