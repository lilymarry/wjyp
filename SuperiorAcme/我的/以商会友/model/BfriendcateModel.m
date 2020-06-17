//
//  Bfriend_cateModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "BfriendcateModel.h"

@implementation BfriendcateModel
- (void)BfriendcateListModelSuccess:(BfriendcateListModelSuccessBlock)success andFailure:(BfriendcateModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.t)) {
        [para setValue:self.t forKey:@"t"];
    }
    
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    if (SWNOTEmptyStr(self.name)) {
        [para setValue:self.name forKey:@"name"];
    }
    if (SWNOTEmptyStr(self.is_del)) {
        [para setValue:self.is_del forKey:@"is_del"];
    }
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    if (SWNOTEmptyStr(self.uid)) {
        [para setValue:self.uid forKey:@"uid"];
    }
    NSLog(@"ssss %@",para);
    [HttpManager postWithUrl:@"OsManager/bfriend_cate" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [BfriendcateModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"BfriendcateModel"};
        }];
        success(dic[@"code"],dic[@"message"],[BfriendcateModel mj_objectWithKeyValues:dic]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
