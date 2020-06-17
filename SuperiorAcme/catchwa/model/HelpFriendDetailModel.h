//
//  HelpFriendDetailModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/15.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^HelpFriendDetailModelSuccessBlock) (NSString * code, NSString * message,id data);

typedef void(^HelpFriendDetailModelFailureBlock) (NSError * error);

@interface HelpFriendDetailModel : NSObject

- (void)HelpFriendDetailModelSuccess:(HelpFriendDetailModelSuccessBlock)success andFailure:(HelpFriendDetailModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
