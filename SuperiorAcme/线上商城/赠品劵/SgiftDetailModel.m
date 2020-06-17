//
//  SgiftDetailModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftDetailModel.h"

@implementation SgiftDetailModel
- (void)SgiftDetailModelSuccess:(SgiftDetailModelSuccessBlock)success andFailure:(SgiftDetailModelFailureBlock)failure {
    [HttpManager postSgiftWithUrl:@"GiftGoods/giftGoodsInfo" baseurl:SgiftBase_url  andParameters:@{@"gift_goods_id":_gift_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SgiftDetailModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"easemob_account":@"SgiftDetailModel",@"promotion":@"SgiftDetailModel",@"ticketList":@"SgiftDetailModel",@"goods_common_attr":@"SgiftDetailModel",@"goodsAttr":@"SgiftDetailModel",@"goods_banner":@"SgiftDetailModel",@"attr_images":@"SgiftDetailModel",@"product":@"SgiftDetailModel",@"pictures":@"SgiftDetailModel",@"goods_active":@"SgiftDetailModel",@"dj_ticket":@"SgiftDetailModel",@"goods_price_desc":@"SgiftDetailModel",@"goods_server":@"SgiftDetailModel",@"goods":@"SgiftDetailModel",@"guess_goods_list":@"SgiftDetailModel",@"goods_attr":@"SgiftDetailModel",@"attr_list":@"SgiftDetailModel",@"goods_attr_first":@"SgiftDetailModel",@"value_list":@"SgiftDetailModel",@"first_list":@"SgiftDetailModel",@"first_list_val":@"SgiftDetailModel",@"first_val":@"SgiftDetailModel",@"list":@"SgiftDetailModel"};
        }];
        success(dic[@"code"],dic[@"message"],[SgiftDetailModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
