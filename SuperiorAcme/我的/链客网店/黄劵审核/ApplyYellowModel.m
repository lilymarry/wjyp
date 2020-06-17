//
//  ApplyYellowModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ApplyYellowModel.h"

@implementation ApplyYellowModel
-(void)ApplyYellowListMethod:(ApplyYellowModelSuccessBlock)success andFailure:(ApplyYellowModelFailureBlock)failure
{ NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [SRegisterLogin shareInstance].method = @"GET";
    
    if (SWNOTEmptyStr(self.shop_id)) {
        [para setValue:self.shopid forKey:@"id"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    [HttpManager postWithUrl:@"Distribution/orders"
               andParameters:para
                  andSuccess:^(id Json) {
                      
                      NSDictionary * dic = (NSDictionary *)Json;
                      success(dic);
                      
                  }
                     andFail:^(NSError *error) {
                         failure(error);
                     }];
    
}
-(void)ShenHeYellowMethod:(ApplyYellowModelSuccessBlock)success andFailure:(ApplyYellowModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [SRegisterLogin shareInstance].method = @"POST";
    
    if (SWNOTEmptyStr(self.order_id)) {
        [para setValue:self.order_id forKey:@"order_id"];
    }
    
    if (SWNOTEmptyStr(self.ticket_status)) {
        [para setValue:self.ticket_status forKey:@"ticket_status"];
    }
    if (SWNOTEmptyStr(self.ticket_price)) {
        [para setValue:self.ticket_price forKey:@"ticket_price"];
    }
    [HttpManager postWithUrl:@"Distribution/setOrderTicket"
               andParameters:para
                  andSuccess:^(id Json) {
                      
                      NSDictionary * dic = (NSDictionary *)Json;
                      success(dic);
                      
                  }
                     andFail:^(NSError *error) {
                         failure(error);
                     }];
    
}
@end
