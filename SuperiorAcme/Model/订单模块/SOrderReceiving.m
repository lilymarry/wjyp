//
//  SOrderReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/7.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderReceiving.h"

@implementation SOrderReceiving

- (void)sOrderReceivingSuccess:(SOrderReceivingSuccessBlock)success andFailure:(SOrderReceivingFailureBlock)failure {
    NSString *urlString = @"";
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if([_orderType isEqualToString:@"无界商店"]){
        urlString = SIntegralOrderReceiving_Url;
    }else{
        urlString = SOrderReceiving_Url;
        [para setValue:_order_goods_id forKey:@"order_goods_id"];
    }
    [para setValue:_order_id forKey:@"order_id"];
    [para setValue:_status forKey:@"status"];
    
    [HttpManager postWithUrl:urlString andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
