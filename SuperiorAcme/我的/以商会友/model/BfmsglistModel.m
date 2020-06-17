//
//  BfmsglistModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "BfmsglistModel.h"

@implementation BfmsglistModel
- (void)BfmsglistModelSuccess:(BfmsglistModelSuccessBlock)success andFailure:(BfmsglistModelFailureBlock)failure
{
     NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    //  NSLog(@"para %@",para);
    [HttpManager postWithUrl:@"OsManager/bfmsglist" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
                [BfmsglistModel mj_setupObjectClassInArray:^NSDictionary *{
                    return @{@"data":@"BfmsglistModel"};
                }];
        success(dic[@"code"],dic[@"message"],[BfmsglistModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
