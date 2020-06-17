//
//  ShengqiangouTitleModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/19.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ShengqiangouTitleModel.h"

@implementation ShengqiangouTitleModel
- (void)ShengqiangouTitleModelSuccess:(ShengqiangouTitleModelSuccessBlock)success andFailure:(ShengqiangouTitleModelFailureBlock)failure
{
    [HttpManager getWithUrl:@"/Goods/getReci" andParameters:nil
    andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [ShengqiangouTitleModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"ShengqiangouTitleModel"};
        }];
        success(dic[@"code"],dic[@"message"],[ShengqiangouTitleModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
