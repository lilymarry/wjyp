//
//  MemberExchangModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MemberExchangModel.h"

@implementation MemberExchangModel
- (void)MemberExchangModelSuccess:(MemberExchangModelSuccessBlock)success andFailure:(MemberExchangModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.shopkeeper_id)) {
        [para setValue:self.shopkeeper_id forKey:@"shopkeeper_id"];
    }
    if (SWNOTEmptyStr(self.sex)) {
        [para setValue:self.sex forKey:@"sex"];
    }
    if (SWNOTEmptyStr(self.age)) {
        [para setValue:self.age forKey:@"age"];
    }
    if (SWNOTEmptyStr(self.member_coding)) {
        [para setValue:self.member_coding forKey:@"member_coding"];
    }
    if (SWNOTEmptyStr(self.city_id)) {
        [para setValue:self.city_id forKey:@"city_id"];
    }
    if (SWNOTEmptyStr(self.cid)) {
        [para setValue:self.cid forKey:@"cid"];//互换请求ID
    }
    if (SWNOTEmptyStr(self.status)) {
        [para setValue:self.status forKey:@"status"];
    }
    if (SWNOTEmptyStr(self.c_id)) {
        [para setValue:self.c_id forKey:@"c_id"];//互换请求ID
    }
    
    NSString *url;
    if ([_flag isEqualToString:@"1"]) {
        url=@"OsManager/app_my_member_list";//我的会员/换入会员
    }
    if ([_flag isEqualToString:@"2"]) {
        url=@"OsManager/app_exchange_user";//会员互换
    }
    if ([_flag isEqualToString:@"3"]) {
        url=@"OsManager/app_exchange_list";//互换请求列表
    }
    if ([_flag isEqualToString:@"4"]) {
        url=@"OsManager/app_member_exchange";//互换会员页头部接口未读数
    }
    if ([_flag isEqualToString:@"5"]) {
        url=@"OsManager/exchange_info";//互换请求详情
    }
    if ([_flag isEqualToString:@"6"]) {
        url=@"OsManager/exchange_log";//互换同意
    }
    if ([_flag isEqualToString:@"7"]) {
        url=@"OsManager/exchange_refuse_log";//互换拒绝
    }
    [HttpManager postWithUrl:url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
       if([[dic allKeys] containsObject:@"num"])
       {
         success(dic[@"code"],dic[@"message"],dic[@"data"],dic[@"num"]);
       }
        else
        {
         success(dic[@"code"],dic[@"message"],dic[@"data"],dic[@"nums"]);
        }
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
