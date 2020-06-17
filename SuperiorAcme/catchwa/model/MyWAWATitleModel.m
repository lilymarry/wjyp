//
//  MyWAWAListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//  我的娃娃

#import "MyWAWATitleModel.h"

@implementation MyWAWATitleModel
- (void)MyWAWATitleModelSuccess:(MyWAWATitleModelSuccessBlock)success andFailure:(MyWAWATitleModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/myAward" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
  
        success(dic[@"code"],dic[@"message"],[MyWAWATitleModel mj_objectWithKeyValues:dic] );
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
