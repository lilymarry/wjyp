//
//  ChangeRoomStatus.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChangeRoomStatusSuccessBlock) (NSString * code, NSString * message);

typedef void(^ChangeRoomStatusFailureBlock) (NSError * error);
@interface ChangeRoomStatus : NSObject
@property(copy ,nonatomic)NSString *   cid ;
@property(copy ,nonatomic)NSString *   type ;

- (void)ChangeRoomStatusSuccess:(ChangeRoomStatusSuccessBlock)success andFailure:(ChangeRoomStatusFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
