//
//  CatchResultModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CatchResultModelSuccessBlock) (NSString * code, NSString * message);
typedef void(^CatchResultModelFailureBlock) (NSError * error);

@interface CatchResultModel : NSObject

@property (nonatomic, copy) NSString * logId;
@property (nonatomic, copy) NSString * mode;

- (void)CatchResultModelSuccess:(CatchResultModelSuccessBlock)success andFailure:(CatchResultModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
