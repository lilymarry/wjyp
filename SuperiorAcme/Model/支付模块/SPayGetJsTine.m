//
//  SPayGetJsTine.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SPayGetJsTine.h"

@implementation SPayGetJsTine

- (void)sPayGetJsTineSuccess:(SPayGetJsTineSuccessBlock)success andFailure:(SPayGetJsTineFailureBlock)failure {
    NSMutableDictionary *pama = [NSMutableDictionary dictionary];
//    if (SWNOTEmptyStr(self.order_id)) {
//        [pama setValue:self.order_id forKey:@"order_id"];
//    }
//    
//    if (SWNOTEmptyStr(self.discount_type)) {
//        [pama setValue:self.discount_type forKey:@"discount_type"];
//    }
    
    if (SWNOTEmptyStr(self.type)) {
        [pama setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.money)) {
        [pama setValue:self.money forKey:@"money"];
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
    
    
    [HttpManager postWithUrl:SPayGetJsTine_Url andParameters:pama andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SPayGetJsTine mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
