//
//  AttrNameModle.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/20.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AttrNameModle.h"

@implementation AttrNameModle
- (void)AttrNameModleSuccess:(AttrNameModleSuccessBlock)success andFailure:(AttrNameModleFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    [HttpManager postWithUrl:@"OsManager/app_stage_goods_attr_list" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
- (void)UpdateAttrNameModleSuccess:(UpdateAttrNameModleSuccessBlock)success andFailure:(AttrNameModleFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    if (SWNOTEmptyArr(self.attr)) {
         [para setValue:[self ArrToJSONString:self.attr] forKey:@"attr"];
    }
    [HttpManager postWithUrl:@"OsManager/appUpdateStageGoodsAttr" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
- (NSString *)ArrToJSONString:(NSArray  *)arr
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:kNilOptions
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}
- (void)DeleteAttrNameModleSuccess:(DeleteAttrNameModleSuccessBlock)success andFailure:(AttrNameModleFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    if (SWNOTEmptyStr(self.attr_id)) {
        [para setValue:self.attr_id forKey:@"attr_id"];
    }
    [HttpManager postWithUrl:@"OsManager/appDeleteAttr" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
