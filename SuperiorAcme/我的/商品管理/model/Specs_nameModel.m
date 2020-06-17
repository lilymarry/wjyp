//
//  Specs_nameModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/20.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "Specs_nameModel.h"

@implementation Specs_nameModel
- (void)Specs_nameModelSuccess:(Specs_nameModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    [HttpManager postWithUrl:@"OsManager/app_stage_goods_property_list" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
- (void)DeleteSpecs_nameModelSuccess:(DeleteSpecs_nameModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.p_id)) {
        [para setValue:self.p_id forKey:@"p_id"];
    }
    
    [HttpManager postWithUrl:@"OsManager/app_delete_property" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
- (void)UpdateSpecs_nameModleSuccess:(UpdateSpecs_nameModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    if (SWNOTEmptyDictionary(self.goods_property)) {
        [para setValue:[self dicToJSONString:self.goods_property] forKey:@"goods_property"];
    }
    [HttpManager postWithUrl:@"OsManager/appAddStageGoodsProperty" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
- (NSString *)dicToJSONString:(NSDictionary  *)arr
{
    NSError *error = nil;
    NSData *jsonData = nil;
    if (!self) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [arr enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyString = nil;
        NSString *valueString = nil;
        if ([key isKindOfClass:[NSString class]]) {
            keyString = key;
        }else{
            keyString = [NSString stringWithFormat:@"%@",key];
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            valueString = obj;
        }else{
            valueString = [NSString stringWithFormat:@"%@",obj];
        }
        
        [dict setObject:valueString forKey:keyString];
    }];
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if ([jsonData length] == 0 || error != nil) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
    
}
- (void)DeleteSpecs_nameBidModelSuccess:(DeleteSpecs_nameBidModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.b_id)) {
        [para setValue:self.b_id forKey:@"b_id"];
    }
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    
    [HttpManager postWithUrl:@"OsManager/app_delete_break_down" andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
