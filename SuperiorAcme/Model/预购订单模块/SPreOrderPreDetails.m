//
//  SPreOrderPreDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreDetails.h"

@implementation SPreOrderPreDetails

- (void)sPreOrderPreDetailsSuccess:(SPreOrderPreDetailsSuccessBlock)success andFailure:(SPreOrderPreDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreDetails_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SPreOrderPreDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SPreOrderPreDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SPreOrderPreDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
