//
//  SOderMangerModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOderMangerModel.h"

@implementation SOderMangerModel
//查看自己购买本店订单列表
-(void)getShopGoodsListMethod:(SOderMangerModelSuccessBlock)success andFailure:(SOderMangerModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    [SRegisterLogin shareInstance].method = @"GET";
    
    if (SWNOTEmptyStr(self.shop_id)) {
        [para setValue:self.shop_id forKey:@"id"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
        if (SWNOTEmptyStr(self.status)) {
            [para setValue:self.status forKey:@"status"];
        }
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    NSLog(@"sssaas %@",para);
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
@end
