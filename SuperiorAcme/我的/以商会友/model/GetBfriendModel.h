//
//  GetBfriendModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetBfriendModelSuccessBlock) (NSString * code, NSString * message, id data);


typedef void (^GetBfriendModelFailureBlock) (NSError * error);


@interface GetBfriendModel : NSObject
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * sta_mid;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * cate_id;
@property (nonatomic, copy) NSString * city_id;
@property (nonatomic, copy) NSString * vinfo;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * bid;
@property (nonatomic, copy) NSString * mid;

@property (nonatomic, copy) NSString * id;

@property (nonatomic, copy) NSString * status;

- (void)GetBfriendModelSuccess:(GetBfriendModelSuccessBlock)success andFailure:(GetBfriendModelFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
