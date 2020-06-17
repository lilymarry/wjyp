//
//  FocusListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
// 获取关注列表  记录关注/取消关注

#import "FocusListModel.h"

@implementation FocusListModel
- (void)FocusListModelSuccess:(FocusListModelSuccessBlock)success andFailure:(FocusListModelFailureBlock)failure{
    [HttpManager postSgiftWithUrl:@"Catcher/getCatcherAttentionList" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [FocusListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"FocusListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[FocusListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
- (void)AddFocusModelSuccess:(AddFocusModelSuccessBlock)success andFailure:(FocusListModelFailureBlock)failure
{
       NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.cid)) {
        [para setValue:self.cid forKey:@"cid"];
    }
    
    if (SWNOTEmptyStr(self.status)) {
        [para setValue:self.status forKey:@"status"];
    }
    
    [HttpManager postSgiftWithUrl:@"Catcher/getCatcherAttention" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [FocusListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"FocusListModel"};
        }];
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

@end
