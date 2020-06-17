//
//  AddAppStageGoodS.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddAppStageGoodS.h"

@implementation AddAppStageGoodS
- (void)AddAppStageGoodSSuccess:(AddAppStageGoodSSuccessBlock)success andFailure:(AddAppStageGoodSFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    if (SWNOTEmptyStr(self.sup_type)) {
        [para setValue:self.sup_type forKey:@"sup_type"];
    }
    
    if (SWNOTEmptyStr(self.name)) {
        [para setValue:self.name forKey:@"name"];
    }
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    if (SWNOTEmptyStr(self.boxware)) {
        [para setValue:self.boxware forKey:@"boxware"];
    }
    if (SWNOTEmptyStr(self.shop_price)) {
        [para setValue:self.shop_price forKey:@"shop_price"];
    }
    
    if (SWNOTEmptyStr(self.church_shop_price)) {
        [para setValue:self.church_shop_price forKey:@"church_shop_price"];
    }
    if (SWNOTEmptyStr(self.label)) {
        [para setValue:self.label forKey:@"label"];
    }
    if (SWNOTEmptyStr(self.desc)) {
        [para setValue:self.desc forKey:@"desc"];
    }
    
    if (SWNOTEmptyStr(self.goods_id)) {
        [para setValue:self.goods_id forKey:@"goods_id"];
    }
    if (SWNOTEmptyStr(self.shop_jiesuan_price)) {
        [para setValue:self.shop_jiesuan_price forKey:@"shop_jiesuan_price"];
    }
    if (SWNOTEmptyStr(self.church_jiesuan_shop_price)) {
        [para setValue:self.church_jiesuan_shop_price forKey:@"church_jiesuan_shop_price"];
    }
    if (SWNOTEmptyStr(self.limit)) {
        [para setValue:self.limit forKey:@"limit"];
    }
    
  if (SWNOTEmptyArr(self.goods_attr)) {
            [para setValue:[self ArrToJSONString:self.goods_attr] forKey:@"goods_attr"];
    }
    if (SWNOTEmptyArr(self.week_price)) {
        [para setValue:[self ArrToJSONString:self.week_price] forKey:@"week_price"];
    }
    if (SWNOTEmptyArr(self.church_week_price)) {
        [para setValue:[self ArrToJSONString:self.church_week_price] forKey:@"church_week_price"];
    }
    
    if (SWNOTEmptyArr(self.goods_property)) {
        [para setValue:[self ArrToJSONString:self.goods_property] forKey:@"goods_property"];
    }
    if (SWNOTEmptyDictionary(self.time_price)) {
        [para setValue:[self dicToJSONString:self.time_price] forKey:@"time_price"];
    }
    if (SWNOTEmptyDictionary(self.church_time_price)) {
        [para setValue:[self dicToJSONString:self.church_time_price] forKey:@"church_time_price"];
    }
    
    
    [HttpManager postUploadMultipleImagesWithUrl:@"OsManager/addAppStageGoods" andImageNames:_ImagesAndNames
                                      andKeyName:@"pic"
                                   andParameters:para andSuccess:^(id Json) {
                                       NSDictionary * dic = (NSDictionary *)Json;
                                       success(dic[@"code"],dic[@"message"] );
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
- (void)AddAfterAppStageGoodSSuccess:(AddAfterAppStageGoodSSuccessBlock)success andFailure:(AddAppStageGoodSFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if (SWNOTEmptyStr(self.sta_mid)) {
        [para setValue:self.sta_mid forKey:@"sta_mid"];
    }
    [HttpManager postWithUrl:@"OsManager/app_after_api" andParameters:para andSuccess:^(id Json) {
       NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],dic[@"data"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
