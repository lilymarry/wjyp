//
//  SUserUserRank.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserRankSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserUserRankFailureBlock) (NSError * error);

@interface SUserUserRank : NSObject

@property (nonatomic, strong) SUserUserRank * data;
@property (nonatomic, copy) NSString * head_pic;//"头像",
@property (nonatomic, copy) NSString * my_rank;//"我的会员等级",
@property (nonatomic, copy) NSString * end_time;//"到期时间"
@property (nonatomic, copy) NSString * icon;//等级图标

@property (nonatomic, copy) NSArray * rank_list;
@property (nonatomic, copy) NSString * rank_id;//"1",//等级id
@property (nonatomic, copy) NSString * rank_name;//"普通会员",//会员名称
@property (nonatomic, copy) NSString * desc;//"享受购物送爱心，利润分成权益",//描述
@property (nonatomic, copy) NSString * money;//"0", //所需消费金额
@property (nonatomic, copy) NSString * is_get;//"1",  //是否获得
@property (nonatomic, copy) NSString * fee;//"永久有效"

- (void)sUserUserRankSuccess:(SUserUserRankSuccessBlock)success andFailure:(SUserUserRankFailureBlock)failure;
@end
