//
//  UserSignModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^UserSignModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^UserSignModelFailureBlock) (NSError * error);

@interface UserSignModel : NSObject
@property (nonatomic, strong) UserSignModel * data;
@property (nonatomic, strong) UserSignModel * sign;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * bgImg;
@property (nonatomic, copy) NSString * prizeImg;
@property (nonatomic, copy) NSString * contentType;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * position;
@property (nonatomic, copy) NSString * remainingNumber;

- (void)UserSignModelSuccess:(UserSignModelSuccessBlock)success andFailure:(UserSignModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
