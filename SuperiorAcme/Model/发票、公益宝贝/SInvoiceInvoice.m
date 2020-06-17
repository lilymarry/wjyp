//
//  SInvoiceInvoice.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SInvoiceInvoice.h"

@implementation SInvoiceInvoice

- (void)sInvoiceInvoiceSuccess:(SInvoiceInvoiceSuccessBlock)success andFailure:(SInvoiceInvoiceFailureBlock)failure {
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    if ([_special_typel isEqualToString:@"无界商店"]) {
        [paramDict setValue:_goods forKey:@"goods"];
        [paramDict setValue:_shop_price?_shop_price:@"" forKey:@"shop_price"];
    }else{
        [paramDict setValue:_goods forKey:@"goods"];
    }
    
    [HttpManager postWithUrl:SInvoiceInvoice_Url andParameters:paramDict andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SInvoiceInvoice mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SInvoiceInvoice"};
        }];
        success(dic[@"code"],dic[@"message"],[SInvoiceInvoice mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
