//
//  SUserMessageAnnounceInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMessageAnnounceInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserMessageAnnounceInfoFailureBlock) (NSError * error);

@interface SUserMessageAnnounceInfo : NSObject
@property (nonatomic, copy) NSString * id;//公告id

@property (nonatomic, strong) SUserMessageAnnounceInfo * data;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * title;//"公告1",//公告标题
@property (nonatomic, copy) NSString * create_time;//"2017-08-11 16:10:07"//发布时间

- (void)sUserMessageAnnounceInfoSuccess:(SUserMessageAnnounceInfoSuccessBlock)success andFailure:(SUserMessageAnnounceInfoFailureBlock)failure;
@end
