//
//  SBalance.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBalance : UIViewController
@property (nonatomic, copy) NSString * user_card_type;//"1无界会员 2无忧会员 3优享会员 4其他会员"
@property (nonatomic, copy) NSString * viewType;//类型 1余额 2赠送代金券
@property (nonatomic, copy) NSString * blueCouponBalance;//蓝色代金券余额
@property (nonatomic, copy) NSArray * blueTickArr;//蓝色代金券
/**
 用户等级 新增类型
 */
@property (nonatomic, copy) NSString * complete_status;


@property (nonatomic, copy) NSString * alliance_merchant;
@property (nonatomic, copy) NSString * shopid;


@end
