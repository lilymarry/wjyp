//
//  SUserUserCard.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserUserCardSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserUserCardFailureBlock) (NSError * error);

@interface SUserUserCard : NSObject

@property (nonatomic, strong) SUserUserCard * data;

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * sale_status;//": "",                 // 销售状态（0->在售，1->禁售）

@property (nonatomic, copy) NSString * score_status;//0已拥有更高级别会员卡 1续费 2开通 4永久有效
@property (nonatomic, copy) NSString * rank_id;//": "",                 // 会员卡id
@property (nonatomic, copy) NSString * rank_name;//": "无界会员",                 // 会员卡名称
@property (nonatomic, copy) NSString * member_coding;//": "14",                 // 会员卡编号
@property (nonatomic, copy) NSString * this_description;//": "消费送积分",             // 会员卡描述
@property (nonatomic, copy) NSString * money;//": "0.00",                               // 会员卡金额
@property (nonatomic, copy) NSString * prescription;//": "0",                            // 会员卡年限
@property (nonatomic, copy) NSString * is_discount;//": "0",                             // 是否优惠（0->否，1->是）
@property (nonatomic, copy) NSString * is_get;//": 1,                                        // 是否获得（0->否，1->是）
@property (nonatomic, copy) NSString * over_time;//会员卡结束时间 如果是0 “永久有效”且删除到期两个字
@property (nonatomic, copy) NSString * pic;//会员卡背景图

@property (nonatomic, copy) NSArray * abs_url;
@property (nonatomic, copy) NSString * url;//"http://wjyp.com/Uploads/UserRank/2018-01-30/5a70072d9dc1c.jpg"       // 权益说明图


@property (nonatomic, copy) NSArray * advertisement;
@property (nonatomic, copy) NSString * type;//": "1",                               //类型（位置1->上方消息 2->下方消息）
@property (nonatomic, copy) NSString * content;//": "内容"                     //内容

- (void)sUserUserCardSuccess:(SUserUserCardSuccessBlock)success andFailure:(SUserUserCardFailureBlock)failure;
@end
