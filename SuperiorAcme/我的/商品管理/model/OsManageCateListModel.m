//
//  OsManageCateListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/22.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManageCateListModel.h"

@implementation OsManageCateListModel
- (void)OsManageCateListModelSuccess:(OsManageCateListModelSuccessBlock)success andFailure:(OsManageCateListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    
    [HttpManager postWithUrl:@"OsManager/app_cate_goods" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [OsManageCateListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"cate_goods_list":@"OsManageCateListModel",@"attr":@"OsManageCateListModel",@"specs":@"OsManageCateListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[OsManageCateListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
