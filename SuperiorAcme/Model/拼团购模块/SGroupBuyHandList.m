//
//  SGroupBuyHandList.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGroupBuyHandList.h"

@implementation SGroupBuyHandList
- (void)SGroupBuyHandListSuccess:(SGroupBuyHandListSuccessBlock)success andFailure:(SGroupBuyHandListFailureBlock)failure
{
NSMutableDictionary *para = [NSMutableDictionary dictionary];



if (SWNOTEmptyStr(self.a_id)) {
    [para setValue:self.a_id forKey:@"a_id"];
}

if (SWNOTEmptyStr(self.p)) {
    [para setValue:self.p forKey:@"p"];
}

if (SWNOTEmptyStr(self.size)) {
    [para setValue:self.size forKey:@"size"];
}
[HttpManager postWithUrl:@"GroupBuy/getAwardRankList" andParameters:para andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    [SGroupBuyHandList mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"rank_list":@"SGroupBuyHandList"};
    }];
    success(dic[@"code"],dic[@"message"],[SGroupBuyHandList mj_objectWithKeyValues:dic]);
} andFail:^(NSError *error) {
    failure(error);
}];
}

@end
