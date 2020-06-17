//
//  SUserUserAddress.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserUserAddress.h"


@implementation SUserUserAddress
- (void)SUserUserAddressSuccess:(SUserUserAddressSuccessBlock)success andFailure:(SUserUserAddressFailureBlock)failure {
    NSDictionary *di=@{@"source":@"2",@"data":_PerSondata};
     NSString *str=[self dictionaryToJSONString:di];
    NSDictionary *didd=@{@"data":str};
    [HttpManager postWithUrl:SUserAddressUrl andParameters:didd andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
- (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
