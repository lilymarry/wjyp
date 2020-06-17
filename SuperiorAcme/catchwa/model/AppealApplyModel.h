//
//  AppealApplyModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/12.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AppealApplyModelSuccessBlock) (NSString * code, NSString * message, id data);

typedef void(^AppealApplyModelFailureBlock) (NSError * error);
@interface AppealApplyModel : NSObject
@property(copy ,nonatomic)NSString *k;
@property(copy ,nonatomic)NSString *value;
@property(strong ,nonatomic)NSArray *data;

- (void)AppealApplyModelSuccess:(AppealApplyModelSuccessBlock)success andFailure:(AppealApplyModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
