//
//  SUserBalanceEditBank.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalanceEditBank.h"

@implementation SUserBalanceEditBank

- (void)sUserBalanceEditBankSuccess:(SUserBalanceEditBankSuccessBlock)success andFailure:(SUserBalanceEditBankFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceEditBank_Url andParameters:@{@"bank_card_id":_bank_card_id,@"name":_name,@"bank_type_id":_bank_type_id,@"open_bank":_open_bank,@"card_number":_card_number,@"phone":_phone} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
