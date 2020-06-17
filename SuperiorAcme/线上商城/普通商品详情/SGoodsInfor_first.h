//
//  SGoodsInfor_first.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGoodsInfor_first : UIViewController
@property (nonatomic, copy) NSString * goods_id;//普通商品、票券商品 详情id

/* overType:
 * Null:普通商品、票券区、进口馆
 * 限量购
 * 拼单购
 * 无界预购
 * 无界商店
 */
@property (nonatomic, copy) NSString * overType;

@property (nonatomic, copy) NSString * a_id;////体验品活动id，非体验品拼单时此id为0
/*
 *从商品详情页返回上一页面时的block回调
 */
@property (nonatomic, copy) void(^PopGoodsInforBlock)();

@property (nonatomic, copy) NSString * gift_goods_id;//赠品区ID
@property (nonatomic, assign) BOOL  Is_399;//普通商品、


@property (nonatomic, copy) NSString * order_id;//寄售人购买的普通订单id

@property (nonatomic, copy) NSString * product_id;////体验品活动id，非体验品拼单时此id为0




@end
