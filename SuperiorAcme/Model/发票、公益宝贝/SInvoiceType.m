//
//  SInvoiceType.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SInvoiceType.h"

@implementation SInvoiceType

- (void)sInvoiceTypeSuccess:(SInvoiceTypeSuccessBlock)success andFailure:(SInvoiceTypeFailureBlock)failure {
    [HttpManager postWithUrl:SInvoiceType_Url andParameters:@{@"goods_id":_goods_id,@"invoice_type":_invoice_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SInvoiceType mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SInvoiceType"};
        }];
        success(dic[@"code"],dic[@"message"],[SInvoiceType mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
