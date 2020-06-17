//
//  SlineDetailWebModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SlineDetailWebModel.h"

@implementation SlineDetailWebModel
- (void)SlineDetailWebModelSuccess:(SlineDetailWebModelSuccessBlock)success andFailure:(SlineDetailWebModelFailureBlock)failure
{
    [HttpManager postUploadMultipleImagesWithUrl:@"Index/upload" andImageNames:_ImagesAndNames
                                      andKeyName:_keyName
                                   andParameters:@{@"save_path    ":_save_path} andSuccess:^(id Json) {
                                       NSDictionary * dic = (NSDictionary *)Json;
                                       success(dic[@"code"],dic[@"message"] ,[self dictionaryToJSONString:dic]);
                                   } andFail:^(NSError *error) {
                                       failure(error);
                                   }];
    
}
- (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
