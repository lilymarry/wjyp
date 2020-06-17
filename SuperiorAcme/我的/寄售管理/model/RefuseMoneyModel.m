//
//  RefuseMoneyModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "RefuseMoneyModel.h"

@implementation RefuseMoneyModel
- (void)RefuseMoneyListModelSuccess:(RefuseMoneyListModelSuccessBlock)success andFailure:(RefuseMoneyListModelFailureBlock)failure
{
    [HttpManager postWithUrl:@"Clean/cause_list" andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [RefuseMoneyModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"RefuseMoneyModel"};
        }];
        success(dic[@"code"],dic[@"message"],[RefuseMoneyModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
- (void)RefuseMoneyModelSuccess:(RefuseMoneyModelSuccessBlock)success andFailure:(RefuseMoneyModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.clean_id)) {
        [para setValue:self.clean_id forKey:@"clean_id"];
    }
    
    if (SWNOTEmptyStr(self.goods_num)) {
        [para setValue:self.goods_num forKey:@"goods_num"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    if (SWNOTEmptyStr(self.cause_id)) {
        [para setValue:self.cause_id forKey:@"cause_id"];
    }
    if (SWNOTEmptyStr(self.reason_desc)) {
        [para setValue:self.reason_desc forKey:@"reason_desc"];
    }
    
   
    [HttpManager postWithUrl:@"Clean/clean_refuse" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
     
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
