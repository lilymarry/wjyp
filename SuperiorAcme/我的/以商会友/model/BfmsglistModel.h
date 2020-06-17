//
//  BfmsglistModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^BfmsglistModelSuccessBlock) (NSString * code, NSString * message, id data);


typedef void (^BfmsglistModelFailureBlock) (NSError * error);


@interface BfmsglistModel : NSObject
@property (nonatomic, copy) NSString * sta_mid;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * bid;
@property (nonatomic, copy) NSString * u_cate_id;
@property (nonatomic, copy) NSString * b_cate_id;
@property (nonatomic, copy) NSString * u_name;
@property (nonatomic, copy) NSString * b_name;
@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * info;
@property (nonatomic, copy) NSString * s_name;
@property (nonatomic, copy) NSString * style;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * phone;

- (void)BfmsglistModelSuccess:(BfmsglistModelSuccessBlock)success andFailure:(BfmsglistModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
