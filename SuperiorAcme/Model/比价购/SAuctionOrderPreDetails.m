//
//  SAuctionOrderPreDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderPreDetails.h"

@implementation SAuctionOrderPreDetails

- (void)sAuctionOrderPreDetailsSuccess:(SAuctionOrderPreDetailsSuccessBlock)success andFailure:(SAuctionOrderPreDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderPreDetails_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAuctionOrderPreDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SAuctionOrderPreDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SAuctionOrderPreDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
