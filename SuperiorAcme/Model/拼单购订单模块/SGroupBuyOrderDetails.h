//
//  SGroupBuyOrderDetails.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderDetailsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyOrderDetailsFailureBlock) (NSError * error);

@interface SGroupBuyOrderDetails : NSObject
@property (nonatomic, copy) NSString * group_buy_order_id;//    订单id

@property (nonatomic, strong) SGroupBuyOrderDetails * data;
@property (nonatomic, copy) NSString * user_name;//": "冯宏达",//用户姓名
@property (nonatomic, copy) NSString * phone;//": "13691077350",//手机号
@property (nonatomic, copy) NSString * order_status;//": "4",//订单状态 （0待付款 1待成团 2待发货 3 待收货 4 待评价 5 已完成  6已取消
@property (nonatomic, copy) NSString * address;//": "北京北京市东城区东华门街道你才是\n",//收货地址
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",//店铺名称

/*
 *订单详情界面添加店铺id
 */
@property (nonatomic, copy) NSString * merchant_id;//店铺id

@property (nonatomic, copy) NSString * leave_message;//": "",//留言
@property (nonatomic, copy) NSString * order_price;//": "24.00",//订单金额
@property (nonatomic, copy) NSString * order_sn;//": "151269874476168",//订单编号
@property (nonatomic, copy) NSString * logistics;//": "您的订单待配货",// 物流状态
@property (nonatomic, copy) NSString * logistics_time;//": "2017-12-7 11:11:11",//物流更新时间
@property (nonatomic, copy) NSString * create_time;//": "1970-01-01 08:00:00", // 创建时间
@property (nonatomic, copy) NSString * pay_time;//": "1970-01-01 08:00:00",//支付时间
@property (nonatomic, copy) NSString * group_buy_id;//" //团购id
@property (nonatomic, copy) NSString * order_type;//" :"1" //订单类型 1直接购买 2开团 3参团
@property (nonatomic, copy) NSString * freight;//"   // 运费
@property (nonatomic, copy) NSString * express_company;//"   // 快递公司名
@property (nonatomic, copy) NSString * express_no;//"           // 快递单号

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * after_sale_status;//":"1存在  0不存在"
@property (nonatomic, copy) NSString * sure_delivery_time;//": "",              // 收货时间
@property (nonatomic, copy) NSString * sale_status;//": "1",              // 是否已延长收货（0->否，1->是）
@property (nonatomic, copy) NSString * after_sale_type;//": "1",              // 是否存在售后（0->不存在，1->存在）

/**
 是否显示申请售后按钮 1为显示
 */
@property (nonatomic, copy) NSString * is_back_apply;
@property (nonatomic, copy) NSString * sure_status;//1支持七天无理由退换货
@property (nonatomic, copy) NSString * server;//": "放弃此商品七天无理由退换货？",              // 确认收货提示框内容
@property (nonatomic, copy) NSString * server_else;//": "注：七天后将自动收货",                    // 确认收货提示框注释内容
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
@property (nonatomic, copy) NSString * return_integral;//":""返回积分数
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * auto_time;//":"系统自动收货时间"
@property (nonatomic, copy) NSString * welfare;//":"公益宝贝//0不存在 其他是金额"
@property (nonatomic, copy) NSString * is_invoice;//":"1开发票 0 不开发票"
@property (nonatomic, copy) NSString * invoice_name;//":"发票名称"
@property (nonatomic, copy) NSString * express_fee;//":"发票运费"
@property (nonatomic, copy) NSString * tax_pay;//":""税金运费
@property (nonatomic, copy) NSString * refund_price;//此商品可退款金额
@property (nonatomic, copy) NSString * is_back_money;//":"0没退钱  1已退钱";
@property (nonatomic, copy) NSString * status;//":"//1->已收货，0->未收货
@property (nonatomic, copy) NSString * integrity_a;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_b;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_c;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_d;//
@property (nonatomic, copy) NSString * remind_status;//":"//0未提醒发货   1以提醒发货"
@property (nonatomic, copy) NSString * a_id;////体验品活动id，非体验品拼单时此id为0

/*
 *拼单购订单详情页内,代金券使用的体现
 */
@property (nonatomic, copy) NSString * pay_tickets;//使用券金额
@property (nonatomic, copy) NSString * ticket_color;// 1红 2黄 3蓝;

@property (nonatomic, copy) NSString * group_type;

- (void)sGroupBuyOrderDetailsSuccess:(SGroupBuyOrderDetailsSuccessBlock)success andFailure:(SGroupBuyOrderDetailsFailureBlock)failure;
@end
