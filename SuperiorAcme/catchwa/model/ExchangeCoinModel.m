//
//  ExchangeCoinModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/2.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ExchangeCoinModel.h"

@implementation ExchangeCoinModel
- (void)ExchangeCoinModelSuccess:(ExchangeCoinModelSuccessBlock)success andFailure:(ExchangeCoinModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.cid)) {
        [para setValue:self.cid forKey:@"cid"];
    }
    
    if (SWNOTEmptyStr(self.times)) {
        [para setValue:self.times forKey:@"times"];
    }
[HttpManager postSgiftWithUrl:@"Catcher/exchangeCoin" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    
    success(dic[@"code"],dic[@"message"] ,dic[@"data"]);
} andFail:^(NSError *error) {
    failure(error);
}];
}
@end
