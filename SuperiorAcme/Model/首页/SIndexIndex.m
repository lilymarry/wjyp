//
//  SIndexIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndexIndex.h"

@implementation SIndexIndex

- (void)sIndexIndexSuccess:(SIndexIndexSuccessBlock)success andFailure:(SIndexIndexFailureBlock)failure {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    
    if (SWNOTEmptyStr(self.lng)) {
        [para setValue:self.lng forKey:@"lng"];
    }
    if (SWNOTEmptyStr(self.lat)) {
        [para setValue:self.lat forKey:@"lat"];
    }
    
    if (SWNOTEmptyStr(self.page_size)) {
        [para setValue:self.page_size forKey:@"page_size"];
    }
    
    [HttpManager postWithUrl:SIndexIndex_Url andParameters:para
            andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIndexIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"index_banner":@"SIndexIndex",@"top_nav":@"SIndexIndex",@"headlines":@"SIndexIndex",@"goodsList":@"SIndexIndex",@"append_person":@"SIndexIndex",@"goods_list":@"SIndexIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SIndexIndex mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
