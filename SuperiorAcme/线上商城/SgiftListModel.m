//
//  SgiftListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftListModel.h"

@implementation SgiftListModel
- (void)SgiftListSuccess:(SgiftListSuccessBlock)success andFailure:(SgiftListFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"giftGoodsIndex" baseurl:SgiftBase_url andParameters:@{@"p":_p}
         andSuccess:^(id Json) {
             NSDictionary * dic = (NSDictionary *)Json;
             success(dic);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
