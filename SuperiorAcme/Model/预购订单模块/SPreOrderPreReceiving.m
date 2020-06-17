//
//  SPreOrderPreReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreReceiving.h"

@implementation SPreOrderPreReceiving

- (void)sPreOrderPreReceivingSuccess:(SPreOrderPreReceivingSuccessBlock)success andFailure:(SPreOrderPreReceivingFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreReceiving_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
