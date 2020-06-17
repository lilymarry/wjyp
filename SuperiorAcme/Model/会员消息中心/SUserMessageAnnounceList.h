//
//  SUserMessageAnnounceList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMessageAnnounceListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserMessageAnnounceListFailureBlock) (NSError * error);

@interface SUserMessageAnnounceList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "公告id",
@property (nonatomic, copy) NSString * content;//": "公告内容",//HTML格式
@property (nonatomic, copy) NSString * status;//": "1",//0 未读 1已读
@property (nonatomic, copy) NSString * is_read;//": 公告状态 "1",//0 未读 1已读
@property (nonatomic, copy) NSString * title;//": "公告标题",
@property (nonatomic, copy) NSString * create_time;//": "2017-08-28 17:23:36",//时间

- (void)sUserMessageAnnounceListSuccess:(SUserMessageAnnounceListSuccessBlock)success andFailure:(SUserMessageAnnounceListFailureBlock)failure;
@end
