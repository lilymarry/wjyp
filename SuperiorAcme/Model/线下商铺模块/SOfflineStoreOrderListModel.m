//
//  SOfflineStoreOrderListModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define SOfflineStoreOrderList_Url @"OfflineStore/orderList"

#import "SOfflineStoreOrderListModel.h"

@implementation SOfflineStoreOrderListModel

- (void)sOfflineStoreOrderListSuccess:(SOfflineStoreOrderListModelSuccessBlock)success andFailure:(SOfflineStoreOrderListModelFailureBlock)failure {
    [HttpManager postWithUrl:SOfflineStoreOrderList_Url andParameters:@{@"pay_status":_pay_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        id data = dic[@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            data = [SOfflineStoreOrderListModel mj_objectArrayWithKeyValuesArray:data];
        }else if ([data isKindOfClass:[NSDictionary class]]){
            data = [SOfflineStoreOrderListModel mj_objectWithKeyValues:data];
        }
        success(dic[@"code"],dic[@"message"],data);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

@end
