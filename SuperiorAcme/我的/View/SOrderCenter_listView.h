//
//  SOrderCenter_listView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOrderOrderList.h"
typedef void(^SOrderCenter_listView_inforBlock) (NSString * order_id ,NSString * order_type);
typedef void(^SOrderCenter_listView_mapBlock) (NSString * shop_name, NSString * lng, NSString * lat);
typedef void(^SOrderCenter_listView_oneBtnClock) (UIButton * btn, NSString * order_id,NSString * goods_id);
typedef void(^SOrderCenter_listView_twoBtnClock) (UIButton * btn, NSString * order_id, NSString * group_buy_id, NSString * order_type, NSString * shop_price, NSString * pic);//后面的id时拼团购需要的id,订单类型 1直接下单 2拼团 3参团

@interface SOrderCenter_listView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UITableView *mTable;

@property (nonatomic, copy) SOrderCenter_listView_inforBlock SOrderCenter_listView_infor;
@property (nonatomic, copy) SOrderCenter_listView_mapBlock SOrderCenter_listView_map;
@property (nonatomic, copy) SOrderCenter_listView_oneBtnClock SOrderCenter_listView_oneBtn;
@property (nonatomic, copy) SOrderCenter_listView_twoBtnClock SOrderCenter_listView_twoBtn;
@property (nonatomic, copy) NSString *list_group_orders_status;//拼单购列表商品状态
/*
 *添加获取拼团赠送的积分的属性
 */
@property (nonatomic, copy) NSString * GivenIntegral;//拼团赠送的积分

@property (nonatomic, copy) NSString *group_buy_type_status;// 拼单购状态下 如果是体验商品 传1 否则传2

@property (nonatomic, copy) NSString * p_id;//": "0"," //开团订单id
@property (nonatomic, assign) BOOL  Is_399;//普通商品、

- (void)showCarModel:(NSArray *)arr andType:(NSString *)thisType;
//- (void)showCarModel:(NSArray *)arr andType:(NSString *)thisType is399:(BOOL)is399;
@end
