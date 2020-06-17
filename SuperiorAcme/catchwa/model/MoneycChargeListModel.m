//
//  MoneycChargeListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
// 获取银两明细

#import "MoneycChargeListModel.h"

@implementation MoneycChargeListModel
- (void)MoneycChargeListModelSuccess:(MoneycChargeListModelSuccessBlock)success andFailure:(MoneycChargeListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    [HttpManager postSgiftWithUrl:@"/Catcher/userCoinLogInfo" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [MoneycChargeListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"MoneycChargeListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[MoneycChargeListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
