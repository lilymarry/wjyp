//
//  Goods_infoModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "Goods_infoModel.h"

@implementation Goods_infoModel
- (void)Goods_infoModelSuccess:(Goods_infoModelSuccessBlock)success andFailure:(Goods_infoModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    
    [HttpManager postWithUrl:@"OsManager/goods_info" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [Goods_infoModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_pic":@"Goods_infoModel",@"week_price":@"Goods_infoModel",@"church_week_price":@"Goods_infoModel"};
        }];
        success(dic[@"code"],dic[@"message"],[Goods_infoModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
