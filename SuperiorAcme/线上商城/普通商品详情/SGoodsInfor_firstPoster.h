//
//  SGoodsInfor_firstPoster.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGoodsGoodsInfo.h"
#import "SLimitBuyLimitBuyInfo.h"
#import "SGroupBuyGroupBuyInfo.h"
#import "SPreBuyPreBuyInfo.h"
#import "SIntegralBuyIntegralBuyInfo.h"
#import "SgiftDetailModel.h"
@interface SGoodsInfor_firstPoster : UIViewController
@property (strong ,nonatomic)SGoodsGoodsInfo *goodsInfor;
@property (strong ,nonatomic)SLimitBuyLimitBuyInfo *LimitBuyInfo;
@property (strong ,nonatomic)SGroupBuyGroupBuyInfo *GroupBuyInfo;
@property (strong ,nonatomic) SPreBuyPreBuyInfo *preBuyPreBuyInfo;
@property (strong ,nonatomic) SIntegralBuyIntegralBuyInfo *integralBuyIntegralBuyInfo;
@property (strong ,nonatomic)  SgiftDetailModel *sgiftDetailModel;;

@property (strong ,nonatomic)  NSString *goodid;;


@property (nonatomic, copy) NSString * overType;
@property (nonatomic, copy) NSString * is_active_5;
@property (nonatomic, copy) NSString * type;


@end
