//
//  SCartAddCollect.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCartAddCollect.h"

@implementation SCartAddCollect

- (void)sCartAddCollectSuccess:(SCartAddCollectSuccessBlock)success andFailure:(SCartAddCollectFailureBlock)failure {
    [HttpManager postWithUrl:SCartAddCollect_Url andParameters:@{@"cart_id_json":_cart_id_json} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
