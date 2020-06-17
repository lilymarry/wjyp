//
//  SUserBalanceAddBank.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceAddBank.h"

@implementation SUserBalanceAddBank

- (void)sUserBalanceAddBankSuccess:(SUserBalanceAddBankSuccessBlock)success andFailure:(SUserBalanceAddBankFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceAddBank_Url andParameters:@{@"name":_name,@"bank_type_id":_bank_type_id,@"open_bank":_open_bank,@"card_number":_card_number,@"phone":_phone} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
