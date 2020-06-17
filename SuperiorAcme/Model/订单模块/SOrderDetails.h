//
//  SOrderDetails.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderDetailsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOrderDetailsFailureBlock) (NSError * error);

@interface SOrderDetails : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

@property (nonatomic, strong) SOrderDetails * data;
@property (nonatomic, copy) NSString * user_name;//": "哈哈哈",                                             // 用户名
@property (nonatomic, copy) NSString * phone;//": "15837925623",                                          // 手机号
@property (nonatomic, copy) NSString * address;//": "天津天津南开区迎水道街道华苑鑫茂科技园1栋B座1809",      // 地址
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",                         // 店铺名
@property (nonatomic, copy) NSString * merchant_id;
@property (nonatomic, copy) NSString * leave_message;//": "",                                                        // 留言
@property (nonatomic, copy) NSString * order_price;//": "19.90",                                                  //总金额
@property (nonatomic, copy) NSString * pay_tickets;//使用券金额
@property (nonatomic, copy) NSString * ticket_color;// 1红 2黄 3蓝;
@property (nonatomic, copy) NSString * order_sn;//": "151253170291037",                              // 订单号
@property (nonatomic, copy) NSString * create_time;//": "2017-12-6",                                        // 创建时间
@property (nonatomic, copy) NSString * pay_time;//": "2017-12-6",
@property (nonatomic, copy) NSString * order_status;//": "0",  //订单状态（0待支付 1待发货  2待收货3 待评价4 已完成 5已取消
@property (nonatomic, copy) NSString * logistics;//":您的订单待配货                                       // 物流状态
@property (nonatomic, copy) NSString * logistics_time;//”：2017-12-7 11:11:11                      //物流更新时间
@property (nonatomic, copy) NSString * freight;//"   // 运费
@property (nonatomic, copy) NSString * express_company;//"   // 快递公司名
@property (nonatomic, copy) NSString * express_no;//"           // 快递单号

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * auto_time;//":"系统自动收货时间"
@property (nonatomic, copy) NSString * sure_delivery_time;//": "",              // 用户收货时间
@property (nonatomic, copy) NSString * welfare;//":"公益宝贝//0不存在 其他是金额"
@property (nonatomic, copy) NSString * is_invoice;//":"1开发票 0 不开发票"
@property (nonatomic, copy) NSString * invoice_name;//":"发票名称"
@property (nonatomic, copy) NSString * express_fee;//":"发票运费"
@property (nonatomic, copy) NSString * tax_pay;//":""税金运费
@property (nonatomic, copy) NSString * sale_status;//": "1",              // 是否已延长收货（0->否，1->是）
@property (nonatomic, copy) NSString * after_sale_status;//":"1存在  0不存在"
/**
 是否显示申请售后按钮 1为显示
 */
@property (nonatomic, copy) NSString * is_back_apply;

@property (nonatomic, copy) NSString * after_sale_type;//"免费维修",              //
@property (nonatomic, copy) NSString * sure_status;//1支持七天无理由退换货
@property (nonatomic, copy) NSString * server;//": "放弃此商品七天无理由退换货？",              // 确认收货提示框内容
@property (nonatomic, copy) NSString * server_else;//": "注：七天后将自动收货",                    // 确认收货提示框注释内容
@property (nonatomic, copy) NSString * order_goods_id;//":"1" //订单商品id
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-11-30/5a1ffaaf89456.jpg",   // 图片
@property (nonatomic, copy) NSString * goods_name;//": "自制DIY微波爆米花 随时自己来一包 就是香脆",
@property (nonatomic, copy) NSString * market_price;//": "30.00",                                // 市场价
@property (nonatomic, copy) NSString * shop_price;//": "28.90",                                  // 售价
@property (nonatomic, copy) NSString * goods_num;//": "1",                                         // 数量
@property (nonatomic, copy) NSString * refund_price;//此商品可退款金额
@property (nonatomic, copy) NSString * attr;//": "重量:250g;口味:辣"
@property (nonatomic, copy) NSString * after_type;//":"0" //商品退货状态 0正常 1退货 2退款成功 3售后拒绝
@property (nonatomic, copy) NSString * is_back_money;//":"0没退钱  1已退钱";
@property (nonatomic, copy) NSString * back_apply_id;//  订单详情每个商品   售后id
@property (nonatomic, copy) NSString * is_sales;//  订单详情每个商品   商家是否同意退货，（0不同意 1同意）
@property (nonatomic, copy) NSString * status;//":"//1->已收货，0->未收货
@property (nonatomic, copy) NSString * integrity_a;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_b;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_c;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_d;//
@property (nonatomic, copy) NSString * remind_status;//":"//0未提醒发货   1以提醒发货"
@property (nonatomic, copy) NSString * return_integral;//":""返回积分数
@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, copy) NSString *gift_goods_id;

@property (nonatomic, copy) NSString *apply_id;
@property (nonatomic, copy) NSString *order_type;

@property (nonatomic, copy) NSString *is_active;
- (void)sOrderDetailsSuccess:(SOrderDetailsSuccessBlock)success andFailure:(SOrderDetailsFailureBlock)failure;
@end
