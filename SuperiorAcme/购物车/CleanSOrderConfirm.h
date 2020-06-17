//
//  CleanSOrderConfirm.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/12.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CleanSOrderConfirm : UIViewController
@property (nonatomic, copy) NSString * order_id;//寄售人购买的普通订单id
@property (nonatomic, copy) NSString * product_id;////体验品活动id，非体验品拼单时此id为0
@property (nonatomic, copy) NSString * num;////体验品活动id，非体验品拼单时此id为0
@property (nonatomic, copy) NSString * goods_id;////体验品活动id，非体验品拼单时此id为0
@end

NS_ASSUME_NONNULL_END
