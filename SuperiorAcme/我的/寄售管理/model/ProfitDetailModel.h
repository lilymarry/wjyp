//
//  ProfitDetailModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ProfitDetailModelSuccessBlock) (NSString * code, NSString * message, NSDictionary * data);
typedef void (^ProfitDetailModelFailureBlock) (NSError * error);
@interface ProfitDetailModel : NSObject
@property (nonatomic, strong) NSString * type;
- (void)ProfitDetailModelModelSuccess:(ProfitDetailModelSuccessBlock)success andFailure:(ProfitDetailModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
