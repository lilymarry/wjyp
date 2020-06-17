//
//  BfriendcateBfListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "BfriendcateBfListModel.h"

@implementation BfriendcateBfListModel
- (void)BfriendcateBfListModelSuccess:(BfriendcateBfListModelSuccessBlock)success andFailure:(BfriendcateBfListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.t)) {
        [para setValue:self.t forKey:@"t"];
    }
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
   
  
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    if (SWNOTEmptyStr(self.uid)) {
        [para setValue:self.uid forKey:@"uid"];
    }
    NSLog(@"para %@",para);
    [HttpManager postWithUrl:@"OsManager/bfriend_cate" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [BfriendcateBfListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"BfriendcateBfListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[BfriendcateBfListModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
@end
