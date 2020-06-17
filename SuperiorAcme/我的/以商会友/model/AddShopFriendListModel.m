//
//  AddShopFriendListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddShopFriendListModel.h"

@implementation AddShopFriendListModel
- (void)AddShopFriendListModelSuccess:(AddShopFriendListModelSuccessBlock)success andFailure:(AddShopFriendListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    [HttpManager postWithUrl:@"OsManager/bfriend" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
     success(dic[@"code"],dic[@"message"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
