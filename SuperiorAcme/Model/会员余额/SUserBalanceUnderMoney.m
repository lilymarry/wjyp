//
//  SUserBalanceUnderMoney.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceUnderMoney.h"

@implementation SUserBalanceUnderMoney

- (void)sUserBalanceUnderMoneySuccess:(SUserBalanceUnderMoneySuccessBlock)success andFailure:(SUserBalanceUnderMoneyFailureBlock)failure {
    [HttpManager postUploadSingleImageWithUrl:SUserBalanceUnderMoney_Url andImageName:_pic andKeyName:@"pic" andParameters:@{@"bank_card_id":_bank_card_id,@"act_time":_act_time,@"money":_money,@"name":_name,@"desc":_desc,@"pay_password":_pay_password,@"platform_account_id":_platform_account_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
