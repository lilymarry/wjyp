//
//  AddGoodManagerEdit_cateModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddGoodManagerEdit_cateModel.h"

@implementation AddGoodManagerEdit_cateModel
- (void)AddGoodManagerEdit_cateModelSuccess:(AddGoodManagerEdit_cateModelSuccessBlock)success andFailure:(AddGoodManagerEdit_cateModelFailureBlock)failure
{
   
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        
        if (SWNOTEmptyStr(self.id)) {
            [para setValue:self.id forKey:@"id"];
        }
        if (SWNOTEmptyStr(self.is_del)) {
            [para setValue:self.is_del forKey:@"is_del"];
        }
        
        if (SWNOTEmptyStr(self.name)) {
            [para setValue:self.name forKey:@"name"];
        }
        if (SWNOTEmptyStr(self.desc)) {
            [para setValue:self.desc forKey:@"desc"];
        }
        if (SWNOTEmptyStr(self.sort)) {
            [para setValue:self.sort forKey:@"sort"];
        }
        if (SWNOTEmptyStr(self.sta_mid)) {
            [para setValue:self.sta_mid forKey:@"sta_mid"];
        }
       
        [HttpManager postWithUrl:@"OsManager/app_edit_cate" andParameters:para andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
  
}
@end
