//
//  SgiftOderListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftOderListModel.h"

@implementation SgiftOderListModel
- (void)SgiftOderListModelSuccess:(SgiftOderListModelSuccessBlock)success andFailure:(SgiftOderListModelFailureBlock)failure {
    
    [HttpManager postSgiftWithUrl:@"GiftGoodsOrder/OrderList" baseurl:SgiftBase_url
        andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SgiftOderListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SgiftOderListModel",@"order_goods":@"SgiftOderListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[SgiftOderListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
