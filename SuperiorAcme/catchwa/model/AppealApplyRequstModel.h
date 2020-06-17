//
//  AppealApplyRequstModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AppealApplyRequstModelSuccessBlock) (NSString * code, NSString * message);

typedef void(^AppealApplyRequstModelFailureBlock) (NSError * error);
@interface AppealApplyRequstModel : NSObject
@property(copy ,nonatomic)NSString *id;
@property(copy ,nonatomic)NSString *type;
@property(copy ,nonatomic)NSString *reason;

- (void)AppealApplyRequstModelSuccess:(AppealApplyRequstModelSuccessBlock)success andFailure:(AppealApplyRequstModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
