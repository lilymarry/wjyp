//
//  GetShengqiangouModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GetShengqiangouModel.h"

@implementation GetShengqiangouModel
- (void)GetShengqiangouModelsSuccess:(GetShengqiangouModelSuccessBlock)success andFailure:(GetShengqiangouModelFailureBlock)failure{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.type)) {
        [para setValue:self.type forKey:@"type"];
    }
    if (SWNOTEmptyStr(self.q)) {
        [para setValue:self.q forKey:@"q"];
    }
    
    if (SWNOTEmptyStr(self.sort_type)) {
        [para setValue:self.sort_type forKey:@"sort_type"];
    }
    if (SWNOTEmptyStr(self.p)) {
        [para setValue:self.p forKey:@"p"];
    }
  //  NSLog(@"sddd %@",para);
    [HttpManager postWithUrl:@"/Goods/getShengqiangou" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [GetShengqiangouModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_list":@"GetShengqiangouModel"};
        }];
        success(dic[@"code"],dic[@"message"],[GetShengqiangouModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
