//
//  OsManageCateMoveModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/24.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManageCateMoveModel.h"

@implementation OsManageCateMoveModel
- (void)OsManageCateMoveModelSuccess:(OsManageCateMoveModelSuccessBlock)success andFailure:(OsManageCateMoveModelFailureBlock)failure
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
   
    if (SWNOTEmptyArr(self.goods_id)) {
        [para setValue:[self ArrToJSONString:self.goods_id] forKey:@"goods_id"];
    }
    
    if (SWNOTEmptyStr(self.cate_id)) {
        [para setValue:self.cate_id forKey:@"cate_id"];
    }
    if (SWNOTEmptyStr(self.is_sale)) {
        [para setValue:self.is_sale forKey:@"is_sale"];
    }
    NSString *url;
    if([_type isEqualToString:@"1"])
    {
        url=@"OsManager/appMoveGoodsToCate";
        
    }
    if([_type isEqualToString:@"2"])
    {
        url=@"OsManager/app_volume_delete";
        
    }
    if([_type isEqualToString:@"3"])
    {
        url=@"OsManager/app_mass_shut_updown";
        
        
    }
    if([_type isEqualToString:@"4"])
    {
        url=@"OsManager/app_dijiao";
    }
    [HttpManager postWithUrl:url andParameters:para andSuccess:^(id Json) {
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
@end
