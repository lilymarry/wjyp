//
//  MyWAWAListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//  我的娃娃

#import "MyWAWAListModel.h"

@implementation MyWAWAListModel
- (void)MyWAWAListModelSuccess:(MyWAWAListModelSuccessBlock)success andFailure:(MyWAWAListModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    
    [HttpManager postSgiftWithUrl:@"Catcher/Mylist" baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [MyWAWAListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"deposit":@"MyWAWAListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[MyWAWAListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
