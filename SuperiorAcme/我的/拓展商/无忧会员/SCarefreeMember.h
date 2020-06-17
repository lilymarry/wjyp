//
//  SCarefreeMember.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCarefreeGrade.h"

@interface SCarefreeMember : UIViewController
@property (nonatomic, copy) NSString * sale_status;//销售状态（0->在售，1->禁售）
@property (nonatomic, copy) NSString * score_status;//0已拥有更高级别会员卡 1续费 2开通 4永久有效 5赠送延长
@property (nonatomic, copy) NSString * rank_id;//会员卡id
@property (nonatomic, copy) NSString * member_coding;//会员卡编号
@property (nonatomic, copy) NSString * rank_name;
@property (nonatomic, copy) NSArray * bannerArr;
@property (nonatomic, copy) NSString * thisMoney;
@property (nonatomic, copy) NSString * is_get;//是否获得（0->否，1->是）

@property (nonatomic, strong) SCarefreeGrade * grade;//支付成功返回
@end
