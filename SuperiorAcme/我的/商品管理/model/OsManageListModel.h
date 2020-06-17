//
//  OsManageListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/22.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^OsManageListModelSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void (^OsManageListModelFailureBlock) (NSError * error);
@interface OsManageListModel : BaseModel
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * sta_mid;

@property (nonatomic, strong) NSArray * data;


@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * m_id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * desc;

@property (nonatomic, copy) NSString * sort;
@property (nonatomic, assign) BOOL isSelect;

- (void)OsManageListModelSuccess:(OsManageListModelSuccessBlock)success andFailure:(OsManageListModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
