//
//  SUserMessageNewMsg.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMessageNewMsg.h"

@implementation SUserMessageNewMsg

- (void)sUserMessageNewMsgSuccess:(SUserMessageNewMsgSuccessBlock)success andFailure:(SUserMessageNewMsgFailureBlock)failure {
    [HttpManager postWithUrl:SUserMessageNewMsg_Url andParameters:@{@"account_json":_account_json,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMessageNewMsg mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"chat_list":@"SUserMessageNewMsg"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMessageNewMsg mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

- (void)sendMessageNewMsgSuccess:(sendMessageNewMsgSuccess)success andFailure:(SUserMessageNewMsgFailureBlock)failure{
    [HttpManager postWithUrl:@"Distribution/shop_msg" andParameters:@{@"type":@"1",@"uid":_uid,@"bid":_bid} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
  
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}


@end
