//
//  EnterRoomModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^EnterRoomModelSuccessBlock) (NSString * code, NSString * message);

typedef void(^EnterRoomModelFailureBlock) (NSError * error);
@interface EnterRoomModel : NSObject
@property(copy ,nonatomic)NSString *   id ;

- (void)EnterRoomModelSuccess:(EnterRoomModelSuccessBlock)success andFailure:(EnterRoomModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
