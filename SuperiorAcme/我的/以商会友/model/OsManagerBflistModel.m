//
//  OsManagerBflistModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/25.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManagerBflistModel.h"

@implementation OsManagerBflistModel
- (void)OsManagerBflistModelSuccess:(OsManagerBflistModelSuccessBlock)success andFailure:(OsManagerBflistModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.t)) {
        [para setValue:self.t forKey:@"t"];
    }

    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    
    [HttpManager postWithUrl:@"OsManager/bflist" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [OsManagerBflistModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"OsManagerBflistModel",@"mInfo":@"OsManagerBflistModel"};
        }];
        success(dic[@"code"],dic[@"message"],[OsManagerBflistModel mj_objectWithKeyValues:dic]);

    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
