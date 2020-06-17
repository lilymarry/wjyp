//
//  Sintegral.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sintegral : UIViewController

@property (nonatomic, copy) NSString * user_card_type;//"1无界会员 2无忧会员 3优享会员 4其他会员
/**
 用户等级 新增类型
 */
@property (nonatomic, copy) NSString * complete_status;

@property (nonatomic, copy) NSString * uct_status;//店主身份

@property (nonatomic, copy) NSString * type;//积分1  银两 2
@property (nonatomic, strong) NSString * chance_num;
@end
