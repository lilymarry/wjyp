//
//  CatchHistoryModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MyCatchHistoryModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^MyCatchHistoryModelFailureBlock) (NSError * error);

@interface MyCatchHistoryModel : NSObject
@property (nonatomic, copy) NSString * p;

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * mode;
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * room_pic;
@property (nonatomic, copy) NSString * video_url;
@property (nonatomic, copy) NSString * roomid;

- (void)MyCatchHistoryModelSuccess:(MyCatchHistoryModelSuccessBlock)success andFailure:(MyCatchHistoryModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
