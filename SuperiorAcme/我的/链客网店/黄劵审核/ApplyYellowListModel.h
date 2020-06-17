//
//  ApplyYellowListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ApplyYellowListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^ApplyYellowListModelFailureBlock) (NSError * error);

@interface ApplyYellowListModel : NSObject
@property (nonatomic, copy) NSString * p;//分页参数
//@property (nonatomic, copy) NSString * giveStatus;//1 是赠送明细  0代金券明细
@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * log_id;//"记录ID",
@property (nonatomic, copy) NSString * act_type;//操作类型 0后台操作1购买会员卡 2普通商品消费  3退回 4积分兑换获得
@property (nonatomic, copy) NSString * add_sub;//":"0增加  1减少"

@property (nonatomic, copy) NSString * reason;//"原因",
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * money;// "交易金额"
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * ticket_price;//
@property (nonatomic, copy) NSString * nickname;//会员卡订单状态
@property (nonatomic, copy) NSString * img;//


- (void)ApplyYellowListModelSuccess:(ApplyYellowListModelSuccessBlock)success andFailure:(ApplyYellowListModelFailureBlock)failure;
@end
