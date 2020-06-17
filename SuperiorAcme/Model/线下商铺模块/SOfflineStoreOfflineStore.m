//
//  SOfflineStoreOfflineStore.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOfflineStoreOfflineStore.h"

@implementation SOfflineStoreOfflineStore

- (void)sOfflineStoreOfflineStoreSuccess:(SOfflineStoreOfflineStoreSuccessBlock)success andFailure:(SOfflineStoreOfflineStoreFailureBlock)failure {
    [HttpManager postWithUrl:SOfflineStoreOfflineStore_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOfflineStoreOfflineStore mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"banner":@"SOfflineStoreOfflineStore",@"brand":@"SOfflineStoreOfflineStore",@"ads":@"SOfflineStoreOfflineStore"};
        }];
        success(dic[@"code"],dic[@"message"],[SOfflineStoreOfflineStore mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
//             @"commentList":@"UBShopDetailCommentModel"
             };
}


@end
