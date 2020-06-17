//
//  SLimitBuyOrderDetails.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderDetailsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SLimitBuyOrderDetailsFailureBlock) (NSError * error);

@interface SLimitBuyOrderDetails : NSObject
@property (nonatomic, copy) NSString * limit_buy_order_id;//    订单id

@property (nonatomic, strong) SLimitBuyOrderDetails * data;
@property (nonatomic, copy) NSString * user_name;//": "冯宏达",//用户姓名
@property (nonatomic, copy) NSString * phone;//": "13691077350",//手机号
@property (nonatomic, copy) NSString * order_status;//": "4",//订单状态（0待支付1待发货2待收货3待评价4已完成 5已取消
@property (nonatomic, copy) NSString * address;//": "北京北京市东城区东华门街道你才是\n",//收货地址
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",//店铺名称
@property (nonatomic, copy) NSString * leave_word;//": "",//留言
@property (nonatomic, copy) NSString * order_price;//": "24.00",//订单金额
@property (nonatomic, copy) NSString * order_sn;//": "151269874476168",//订单编号
@property (nonatomic, copy) NSString * logistics;//": "您的订单待配货",// 物流状态
@property (nonatomic, copy) NSString * logistics_time;//";/: "2017-12-7 11:11:11",//物流更新时间
@property (nonatomic, copy) NSString * create_time;//": "1970-01-01 08:00:00", // 创建时间
@property (nonatomic, copy) NSString * pay_time;//": "1970-01-01 08:00:00",//支付时间
@property (nonatomic, copy) NSString * group_buy_id;//"; //团购id
@property (nonatomic, copy) NSString * order_type;//" :"1" //订单类型 1直接购买 2开团 3参团

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * order_goods_id;//":"1" //订单商品id
@property (nonatomic, copy) NSString * goods_name;//": "美式球形爆米花 香甜酥脆到爆 看片好伙伴 休闲零食小吃",//商品名称
@property (nonatomic, copy) NSString * market_price;//": "30.00",//
@property (nonatomic, copy) NSString * shop_price;//": "26.60",//商品价格
@property (nonatomic, copy) NSString * goods_num;//": "2",//购买数量
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b9c3370d7.jpg",//商品图
@property (nonatomic, copy) NSString * attr;//": """重量:1000g;口味:甜"
@property (nonatomic, copy) NSString * after_type;//":"0" //商品退货状态 0正常 1退货 2退款成功
@property (nonatomic, copy) NSString * back_apply_id;//  订单详情每个商品   售后id
@property (nonatomic, copy) NSString * is_sales;//  订单详情每个商品   商家是否同意退货，（0不同意 1同意）

- (void)sLimitBuyOrderDetailsSuccess:(SLimitBuyOrderDetailsSuccessBlock)success andFailure:(SLimitBuyOrderDetailsFailureBlock)failure;
@end
