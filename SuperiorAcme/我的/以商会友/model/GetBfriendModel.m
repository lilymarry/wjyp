//
//  GetBfriendModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GetBfriendModel.h"

@implementation GetBfriendModel
- (void)GetBfriendModelSuccess:(GetBfriendModelSuccessBlock)success andFailure:(GetBfriendModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    if (SWNOTEmptyStr(self.phone)) {
        [para setValue:self.phone forKey:@"phone"];
    }
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    if (SWNOTEmptyStr(self.vinfo)) {
        [para setValue:self.vinfo forKey:@"vinfo"];
    }
    if (SWNOTEmptyStr(self.nickname)) {
        [para setValue:self.nickname forKey:@"nickname"];
    }
    if (SWNOTEmptyStr(self.bid)) {
        [para setValue:self.bid forKey:@"bid"];
    }
    if (SWNOTEmptyStr(self.mid)) {
        [para setValue:self.mid forKey:@"mid"];
    }
    if (SWNOTEmptyStr(self.id)) {
        [para setValue:self.id forKey:@"id"];
    }
    if (SWNOTEmptyStr(self.vinfo)) {
        [para setValue:self.vinfo forKey:@"vinfo"];
    }
    if (SWNOTEmptyStr(self.status)) {
        [para setValue:self.status forKey:@"status"];
    }
    if (SWNOTEmptyStr(self.city_id)) {
        [para setValue:self.city_id forKey:@"city_id"];
    }
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    NSLog(@"para %@",para);
    [HttpManager postWithUrl:@"OsManager/get_bfriend" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
//        [GetBfriendModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{@"data":@"GetBfriendModel"};
//        }];
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
        
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
