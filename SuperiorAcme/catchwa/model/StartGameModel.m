//
//  StartGameModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
// 开始游戏

#import "StartGameModel.h"

@implementation StartGameModel
- (void)startGameModelSuccess:(startGameModelSuccessBlock)success andFailure:(startGameModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/startGame" baseurl:SgiftBase_url  andParameters:@{@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[StartGameModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
