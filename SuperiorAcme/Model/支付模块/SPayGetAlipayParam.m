//
//  SPayGetAlipayParam.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPayGetAlipayParam.h"

@implementation SPayGetAlipayParam

- (void)sPayGetAlipayParamSuccess:(SPayGetAlipayParamSuccessBlock)success andFailure:(SPayGetAlipayParamFailureBlock)failure {
    NSMutableDictionary *pama = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.type)) {
        [pama setValue:self.type forKey:@"type"];
    }
    
    if ([self.type intValue]==17) {
        if (SWNOTEmptyStr(self.order_id)) {
            [pama setValue:self.order_id forKey:@"divination_id"];
        }
        
        if (SWNOTEmptyStr(self.discount_type)) {
            [pama setValue:self.discount_type forKey:@"divination_type"];
        }
    }
    else
    {
        if (SWNOTEmptyStr(self.order_id)) {
            [pama setValue:self.order_id forKey:@"order_id"];
        }
        
        if (SWNOTEmptyStr(self.discount_type)) {
            [pama setValue:self.discount_type forKey:@"discount_type"];
        }
    }
    
    [HttpManager postWithUrl:SPayGetAlipayParam_Url andParameters:pama andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SPayGetAlipayParam mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
