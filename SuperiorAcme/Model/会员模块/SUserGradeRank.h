//
//  SUserGradeRank.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserGradeRankSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserGradeRankFailureBlock) (NSError * error);

@interface SUserGradeRank : NSObject
@property (nonatomic, copy) NSString * city_name;//城市名称
@property (nonatomic, copy) NSString * type;//type = 'share' 显示分享排行（默认） type = 'recommend' 显示推荐排行
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SUserGradeRank * data;
@property (nonatomic, copy) NSString * id;//"1",
@property (nonatomic, copy) NSString * nickname;//"会员昵称",
@property (nonatomic, copy) NSString * head_pic;//"会员头像",
@property (nonatomic, copy) NSString * recommend_num;//"推荐人数",
@property (nonatomic, copy) NSString * share_num;//"分享次数",
@property (nonatomic, copy) NSString * parent_name;//推荐人
/*
 *添加是否有权限无线查看属性
 */
@property (nonatomic, copy) NSString * infinite;//是否有权限无线查看

// 排行榜
@property (nonatomic, copy) NSArray * rank_list;
@property (nonatomic, copy) NSString * parent_id;//"1",
@property (nonatomic, copy) NSString * num;//"次数",
@property (nonatomic, copy) NSString * recommend_rank;
@property (nonatomic, copy) NSString * share_rank;

- (void)sUserGradeRankSuccess:(SUserGradeRankSuccessBlock)success andFailure:(SUserGradeRankFailureBlock)failure;
@end
