//
//  SWelfareTicketList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SWelfareTicketListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SWelfareTicketListFailureBlock) (NSError * error);

@interface SWelfareTicketList : NSObject
@property (nonatomic, copy) NSString * cate_id;//分类id（可选）
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SWelfareTicketList * data;

//导航
@property (nonatomic, copy) NSArray * top_nav;
//@property (nonatomic, copy) NSString * cate_id;//": "分类id",
@property (nonatomic, copy) NSString * short_name;//": "分类简称",
@property (nonatomic, copy) NSString * name;//": "分类名称"

//优惠券列表
@property (nonatomic, copy) NSArray * ticket_list;

@property (nonatomic, copy) NSString * ticket_id;//": "优惠券id",
@property (nonatomic, copy) NSString * ticket_name;//": "优惠券名称",
@property (nonatomic, copy) NSString * ticket_desc;//": "优惠券描述",
@property (nonatomic, copy) NSString * ticket_type;//": "优惠券类型",//1 满减 2满折 3满赠
@property (nonatomic, copy) NSString * value;//": "12",//满减=>金额 满折=>折扣 满赠=>商品id
@property (nonatomic, copy) NSString * condition;//": "满足条件",
@property (nonatomic, copy) NSString * merchant_id;//": "店铺ID",
@property (nonatomic, copy) NSString * end_time;//": "失效时间",
@property (nonatomic, copy) NSString * start_time;//": "开始时间"
@property (nonatomic, copy) NSString * ticket_num;//": "优惠券总数量",
@property (nonatomic, copy) NSString * use_num;//": "被领取数量",
@property (nonatomic, copy) NSString * logo;//’:商家logo
@property (nonatomic, copy) NSString * is_get;//:'1 已领取  0未领取'

- (void)sWelfareTicketListSuccess:(SWelfareTicketListSuccessBlock)success andFailure:(SWelfareTicketListFailureBlock)failure;
@end
