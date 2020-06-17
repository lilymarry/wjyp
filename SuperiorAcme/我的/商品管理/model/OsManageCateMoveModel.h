//
//  OsManageCateMoveModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/24.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^OsManageCateMoveModelSuccessBlock) (NSString * code, NSString * message);
typedef void (^OsManageCateMoveModelFailureBlock) (NSError * error);
@interface OsManageCateMoveModel : NSObject
@property (nonatomic, copy) NSString * cate_id;
@property (nonatomic, strong) NSArray* goods_id;
@property (nonatomic, strong) NSString* type; //1 批量移动 2 批量删除  3 批量起售停售
@property (nonatomic, strong) NSString* is_sale; //0下架 1上架

- (void)OsManageCateMoveModelSuccess:(OsManageCateMoveModelSuccessBlock)success andFailure:(OsManageCateMoveModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
