//
//  SUserMyRecommend.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMyRecommendSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserMyRecommendFailureBlock) (NSError * error);

@interface SUserMyRecommend : NSObject
@property (nonatomic, copy) NSString * p;//分页参数
@property (nonatomic, copy) NSString * parent_id;//    父级id 默认是自己的推荐人 传入值查看对应id 下的推荐人

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//":会员id
@property (nonatomic, copy) NSString * nickname;//"昵称",
@property (nonatomic, copy) NSString * head_pic;//"头像",
@property (nonatomic, copy) NSString * phone;//"139****8462",//手机
@property (nonatomic, copy) NSString * create_time;//"2017-07-29"、//时间
@property (nonatomic, copy) NSString * recommend_num;//"推荐成功人数"


/*
 *添加推荐新接口返回的新添加的字段
 */
@property (nonatomic, copy) NSString * num;//"推荐成功人数"
@property (nonatomic, copy) NSString * member_coding;//1无界 2无忧 3优享
@property (nonatomic, copy) NSString * time;//成为会员级别时间
@property (nonatomic, copy) NSString * umbrella_coding_one;//伞下无界
@property (nonatomic, copy) NSString * umbrella_coding_two;//伞下无忧
@property (nonatomic, copy) NSString * umbrella_coding_three;//伞下优享
@property (nonatomic, copy) NSString * coding_one;//直推无界人数
@property (nonatomic, copy) NSString * coding_two;//直推无忧人数
@property (nonatomic, copy) NSString * coding_three;//直推优享人数
@property (nonatomic, copy) NSString * umbrella_icon;//伞下图标
@property (nonatomic, copy) NSString * straight_icon;//手掌图标
@property (nonatomic, copy) NSString * grow_point;//

- (void)sUserMyRecommendSuccess:(SUserMyRecommendSuccessBlock)success andFailure:(SUserMyRecommendFailureBlock)failure;
@end
