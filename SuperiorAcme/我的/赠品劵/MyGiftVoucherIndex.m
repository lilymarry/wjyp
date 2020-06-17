//
//  MyGiftVoucherIndex.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "MyGiftVoucherIndex.h"

@implementation MyGiftVoucherIndex
- (void)MyGiftVoucherIndexSuccess:(MyGiftVoucherIndexSuccessBlock)success andFailure:(MyGiftVoucherIndexFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"GiftGoodsVouchers/giftVoucherIndex" baseurl:SgiftBase_url andParameters:@{@"p":_p} andSuccess:^(id Json) {
         NSDictionary * dic = (NSDictionary *)Json;
        [MyGiftVoucherIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"giftlist":@"MyGiftVoucherIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[MyGiftVoucherIndex mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
//赠品券兑换接口
- (void)MyGiftVoucherChangeIndexSuccess:(MyGiftVoucherIndexChangeSuccessBlock)success andFailure:(MyGiftVoucherIndexFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"GiftGoodsVouchers/changeMoney" baseurl:SgiftBase_url andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
