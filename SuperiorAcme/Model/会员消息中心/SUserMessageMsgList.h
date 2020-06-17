//
//  SUserMessageMsgList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMessageMsgListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserMessageMsgListFailureBlock) (NSError * error);

@interface SUserMessageMsgList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "3",
@property (nonatomic, copy) NSString * user_id;//": "会员id",
@property (nonatomic, copy) NSString * text_id;//": "3",
@property (nonatomic, copy) NSString * status;//": "1",//0 未读 1已读
@property (nonatomic, copy) NSString * content;//": "内容",
@property (nonatomic, copy) NSString * create_time;//": "2017-09-12 11:25:01"//时间

- (void)sUserMessageMsgListSuccess:(SUserMessageMsgListSuccessBlock)success andFailure:(SUserMessageMsgListFailureBlock)failure;
@end
