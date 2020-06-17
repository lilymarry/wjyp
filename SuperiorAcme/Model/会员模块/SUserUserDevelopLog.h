//
//  SUserUserDevelopLog.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserDevelopLogSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserUserDevelopLogFailureBlock) (NSError * error);

@interface SUserUserDevelopLog : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * time;//"月份",

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * log_id;//"记录id",
@property (nonatomic, copy) NSString * reason;//"原因",
@property (nonatomic, copy) NSString * get_point;//"得到成长值",
@property (nonatomic, copy) NSString * create_time;//"日期"
@property (nonatomic, copy) NSString * img;//

- (void)sUserUserDevelopLogSuccess:(SUserUserDevelopLogSuccessBlock)success andFailure:(SUserUserDevelopLogFailureBlock)failure;
@end
