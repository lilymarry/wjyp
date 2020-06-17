//
//  BfriendcateBfListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BfriendcateBfListModelSuccessBlock) (NSString * code, NSString * message, id data);


typedef void (^BfriendcateBfListModelFailureBlock) (NSError * error);


@interface BfriendcateBfListModel : NSObject
@property (nonatomic, copy) NSString * t;
@property (nonatomic, copy) NSString * sta_mid;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * id;

@property (nonatomic, strong) BfriendcateBfListModel * data;

@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * count;
@property (nonatomic, strong) NSArray * list;

@property (nonatomic, copy) NSString * bid;
@property (nonatomic, copy) NSString * u_cate_id;
@property (nonatomic, copy) NSString * b_cate_id;
@property (nonatomic, copy) NSString * u_name;
@property (nonatomic, copy) NSString * b_name;


@property (nonatomic, copy) NSString * add_time;
@property (nonatomic, copy) NSString * u_vinfo;
@property (nonatomic, copy) NSString * b_vinfo;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * real_uid;
@property (nonatomic, copy) NSString * head_pic;


- (void)BfriendcateBfListModelSuccess:(BfriendcateBfListModelSuccessBlock)success andFailure:(BfriendcateBfListModelFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
