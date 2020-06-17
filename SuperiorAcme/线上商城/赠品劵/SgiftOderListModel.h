//
//  SgiftOderListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SgiftOderListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SgiftOderListModelFailureBlock) (NSError * error);
@interface SgiftOderListModel : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态（'0': '待付款‘ ； '1': '待发货' ； '2': '待收货' ；'3': '待评价'；'4': '已完成；‘5’：取消订单） 默认9（全部）    否    文本    9
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "108",             //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",          //订单状态
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * merchant_id;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * goods_id;//": 36,                 //订单总额
@property (nonatomic, copy) NSString * order_price;//": "12",         //商品id
@property (nonatomic, copy) NSString * freight;//": "6",       //商品数量
@property (nonatomic, copy) NSString * create_time;//"   // 运费;

@property (nonatomic, copy) NSString * order_goods_id;//": "108",             //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",          //订单状态
@property (nonatomic, copy) NSString * use_voucher;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * goods_name;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * goods_num;//": 36,                 //订单总额
@property (nonatomic, copy) NSString * goods_attr;//": "12",         //商品id
@property (nonatomic, copy) NSString * remind_status;//": "6",       //商品数量
@property (nonatomic, copy) NSString * sale_status;//"   // 运费;

@property (nonatomic, copy) NSString * goods_img;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * attr_combine_id;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * arrt_name;//": 36,                 //订单总额
@property (nonatomic, copy) NSString * arrt_value;//": "12",         //商品id
@property (nonatomic, copy) NSString * shop_price;//": "6",       //商品数量





@property (nonatomic, copy) NSArray * order_goods;
@property (nonatomic, copy) NSString * pic;//": "6.00",                //商品单价

- (void)SgiftOderListModelSuccess:(SgiftOderListModelSuccessBlock)success andFailure:(SgiftOderListModelFailureBlock)failure;
@end
