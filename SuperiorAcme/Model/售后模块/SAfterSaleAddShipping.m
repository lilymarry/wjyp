//
//  SAfterSaleAddShipping.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAfterSaleAddShipping.h"

@implementation SAfterSaleAddShipping

- (void)sAfterSaleAddShippingSuccess:(SAfterSaleAddShippingSuccessBlock)success andFailure:(SAfterSaleAddShippingFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleAddShipping_Url andParameters:@{@"shipping_id":_shipping_id,@"invoice":_invoice,@"back_apply_id":_back_apply_id,@"receiver":_receiver,@"receiver_phone":_receiver_phone,@"province":_province,@"city":_city,@"area":_area,@"street":_street,@"address":_address} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
