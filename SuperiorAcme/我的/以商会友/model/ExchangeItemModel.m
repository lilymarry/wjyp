//
//  ExchangeItemModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ExchangeItemModel.h"

@implementation ExchangeItemModel
- (void)ExchangeItemModelSuccess:(ExchangeItemModelSuccessBlock)success andFailure:(ExchangeItemModelFailureBlock)failure
{
    NSString *url;
    if ([_type isEqualToString:@"1"]) {
        url=@"OsManager/app_stage_merchant_user";//店主列表
    }
    else
    {
        url=@"OsManager/app_age_bracket";//年龄
    }
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
  
    
    [HttpManager postWithUrl:url andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
