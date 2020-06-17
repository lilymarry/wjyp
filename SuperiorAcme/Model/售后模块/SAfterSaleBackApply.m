//
//  SAfterSaleBackApply.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAfterSaleBackApply.h"

@implementation SAfterSaleBackApply

- (void)sAfterSaleBackApplySuccess:(SAfterSaleBackApplySuccessBlock)success andFailure:(SAfterSaleBackApplyFailureBlock)failure {
    [HttpManager postUploadMultipleImagesWithUrl:SAfterSaleBackApply_Url andImagesAndNames:_back_img andParameters:@{@"reason":_reason,@"back_money":_back_money,@"back_desc":_back_desc,@"goods_status":_goods_status,@"cause":_cause,@"order_id":_order_id,@"order_type":_order_type,@"order_goods_id":_order_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
