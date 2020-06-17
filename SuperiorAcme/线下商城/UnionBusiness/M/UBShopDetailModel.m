//
//  UBShopDetailModel.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBShopDetailModel.h"

@implementation UBShopDetailModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"commentList":@"UBShopDetailCommentModel",
             @"other_license":@"UBShopLicenseModel"
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"commentCount":@"comment.count",
             @"commentStar_cate":@"comment.star_cate",
             @"commentList":@"comment.list"
             };
}

@end

#pragma mark - 评论模型
@implementation UBShopDetailCommentModel

//全部评论使用
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":@"UBShopDetailCommentModel"
             };
}

@end


@implementation UBShopLicenseModel
@end
