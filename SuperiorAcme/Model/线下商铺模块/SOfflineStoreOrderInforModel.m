//
//  SOfflineStoreOrderInforModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define SOfflineStoreOrderInfo_Url @"OfflineStore/orderInfo"
#define KOfflineStoreDelOrder_Url  @"OfflineStore/delOrder"  //取消和删除订单

#import "SOfflineStoreOrderInforModel.h"

@implementation SOfflineStoreOrderInforModel

- (void)sOfflineStoreOrderInfoSuccess:(SOfflineStoreOrderInforModelSuccessBlock)success andFailure:(SOfflineStoreOrderInforModelFailureBlock)failure {
    [HttpManager postWithUrl:SOfflineStoreOrderInfo_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        id data = dic[@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            data = [SOfflineStoreOrderInforModel mj_objectArrayWithKeyValuesArray:data];
        }else if ([data isKindOfClass:[NSDictionary class]]){
            data = [SOfflineStoreOrderInforModel mj_objectWithKeyValues:data];
        }
        success(dic[@"code"],dic[@"message"],data);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

- (void)sOfflineStoreDelOrderSuccess:(SOfflineStoreOrderInforModelSuccessBlock)success andFailure:(SOfflineStoreOrderInforModelFailureBlock)failure{
    [HttpManager postWithUrl:KOfflineStoreDelOrder_Url
               andParameters:@{@"order_id":_order_id,@"order_status":_order_status}
                  andSuccess:^(id Json) {
                      NSDictionary * dic = (NSDictionary *)Json;
                      success(dic[@"code"],dic[@"message"],nil);
                  }
                     andFail:^(NSError *error) {
                       failure(error);
                     }];
}



@end
