//
//  GetMerchantCate.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GetMerchantCate.h"

@implementation GetMerchantCate
- (void)GetMerchantCateSuccess:(GetMerchantCateSuccessBlock)success andFailure:(GetMerchantCateFailureBlock)failure

{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
 
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    
    [HttpManager postWithUrl:@"OsManager/getMerchantCate" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
