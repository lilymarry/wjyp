//
//  WAfirstItemListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/26.
//  Copyright © 2019年 GYM. All rights reserved.
// 首页列表筛选

#import "WAfirstItemListModel.h"

@implementation WAfirstItemListModel
- (void)WAfirstItemListModelSuccess:(WAfirstItemListModelSuccessBlock)success andFailure:(WAfirstItemListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.clumn)) {
        [para setValue:self.clumn forKey:@"clumn"];
    }
    
    if (SWNOTEmptyStr(self.status)) {
        [para setValue:self.status forKey:@"status"];
    }
    if (SWNOTEmptyStr(self.per)) {
        [para setValue:self.per forKey:@"per"];
    }
    [HttpManager postSgiftWithUrl:@"Catcher/catcherFilter" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [WAfirstItemListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"WAfirstItemListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[WAfirstItemListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
