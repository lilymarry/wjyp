//
//  OsManageListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/22.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManageListModel.h"

@implementation OsManageListModel
- (void)OsManageListModelSuccess:(OsManageListModelSuccessBlock)success andFailure:(OsManageListModelFailureBlock)failure {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    
      [HttpManager postWithUrl:@"OsManager/app_goods_cate" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [OsManageListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"OsManageListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[OsManageListModel mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
