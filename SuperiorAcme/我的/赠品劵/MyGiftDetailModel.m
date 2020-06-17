//
//  MyGiftDetailModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/29.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "MyGiftDetailModel.h"

@implementation MyGiftDetailModel
- (void)MyGiftDetailModelSuccess:(MyGiftDetailModelSuccessBlock)success andFailure:(MyGiftDetailModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"GiftGoodsVouchers/getGiftVouchersInfo" baseurl:SgiftBase_url andParameters:@{@"p":_p,@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [MyGiftDetailModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MyGiftDetailModel"};
        }];
        success(dic[@"code"],dic[@"message"],[MyGiftDetailModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
@end
