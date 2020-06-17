//
//  SFightGroups.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SFightGroups : UIViewController
@property (nonatomic, copy) NSString * group_buy_order_id;//参团订单ID
@property (nonatomic, copy) NSString * group_buy_id;//
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    1
//@property (nonatomic, copy) NSString * num;//    数量    否    文本    1
@property (nonatomic, copy) NSString * product_id;//    组和属性id    否    文本    1
@property (nonatomic, copy) NSString * merchant_id;//    商家id

@property (nonatomic, copy) NSString * shop_price_buy;
@property (nonatomic, copy) NSString * good_img_buy;
@property (nonatomic, copy) NSArray * goods_attr_arr;
@property (nonatomic, copy) NSArray * contrastArr;
@property (nonatomic, copy) NSString * model_one_first_name;//主属性名
@property (nonatomic, copy) NSString * model_two_first_name;//副属性名

/*
 *添加获取拼团赠送的积分的属性
 */
@property (nonatomic, copy) NSString * GivenIntegral;//拼团赠送的积分

@property (nonatomic, copy) NSString *group_buy_type_status;// 拼单购状态下 如果是体验商品 传1 否则传2


@end
