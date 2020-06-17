//
//  SShopSetModel.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopSetModel.h"

@implementation SShopSetModel

//更新店铺的信息
+ (void)UpdateShopMessageWithDict:(NSDictionary *)shopMessageDict andSuccess:(SShopSetModelSuccessBlock)success andFailure:(SShopSetModelFailureBlock)failure {
    UIImage * shopIconImage = shopMessageDict[@"shopIconImage"];
    NSString * shopID = shopMessageDict[@"id"];
    NSString * shopName = shopMessageDict[@"shopName"];
    NSString * shopDesc = shopMessageDict[@"shopDesc"];
     [SRegisterLogin shareInstance].method = @"PUT";
    [HttpManager postShopUploadSingleImageWithUrl:@"Distribution/shops" andImageName:shopIconImage andKeyName:@"shop_pic" andParameters:@{@"id":shopID,@"shop_name":shopName,@"shop_desc":shopDesc} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        id data = dic[@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            [SShopSetModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"data":@"SShopSetModel"};
            }];
            data = [SShopSetModel mj_objectArrayWithKeyValuesArray:data];
        }else{
            data = [SShopSetModel mj_objectWithKeyValues:data];
        }
        success(dic[@"code"],dic[@"message"],data,dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
