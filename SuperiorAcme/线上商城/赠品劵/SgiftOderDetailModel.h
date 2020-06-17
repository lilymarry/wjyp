//
//  SgiftOderDetailModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SgiftOderDetailModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SgiftOderDetailModelFailureBlock) (NSError * error);

@interface SgiftOderDetailModel : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

@property (nonatomic, strong) SgiftOderDetailModel * data;

@property (nonatomic, copy) NSString * express_company;//": "您的订单待配货",            //物流状态
@property (nonatomic, copy) NSString * express_no;//": "2017-12-7 11:11:11",     //物流更新时间
@property (nonatomic, copy) NSString * leave_message;//": "哈哈哈",          //用户名
@property (nonatomic, copy) NSString * order_type;//": "3",              //商品数量
@property (nonatomic, copy) NSString * freight; //订单状态（0待支付 1待发货  2待收货3 待评价4 已完成 5已取消
@property (nonatomic, copy) NSString * user_name;//": "15837925623",          //手机号
@property (nonatomic, copy) NSString * phone;//": "天津天津南开区迎水道街道华苑鑫茂科技园1栋B座1809",           //地址
@property (nonatomic, copy) NSString * order_status;//": "得一蜂业旗舰店",               //店铺名称
@property (nonatomic, copy) NSString * address;//": "30.00",                                    //总金额
@property (nonatomic, copy) NSString * merchant_name;//": "151357572269567",               //订单号
@property (nonatomic, copy) NSString * merchant_id;//": "2017-12-18 13:42:02",          //创建时间
@property (nonatomic, copy) NSString * leave_word;//": "1970-01-01 08:00:00",            //支付时间
@property (nonatomic, copy) NSString * order_price;//"   // 运费
@property (nonatomic, copy) NSString * order_sn;//"   // 快递公司名
@property (nonatomic, copy) NSString * pay_tickets;//"           // 快递单号
@property (nonatomic, copy) NSString * ticket_color;//备注
@property (nonatomic, copy) NSString * o_return_integral;//":"1存在  0不存在"
@property (nonatomic, copy) NSString * logistics;//":"1" //订单商品id

@property (nonatomic, copy) NSString * logistics_time;
@property (nonatomic, copy) NSString * pay_time;//使用券金额
@property (nonatomic, copy) NSString * create_time;// 1红 2黄 3蓝;
@property (nonatomic, copy) NSString * is_pay_password;//使用券金额
@property (nonatomic, copy) NSString * shop_name;// 1红 2黄 3蓝;

@property (nonatomic, copy) NSArray * list;
/**
 是否显示申请售后按钮 1为显示
 */
@property (nonatomic, copy) NSString * sure_status;
@property (nonatomic, copy) NSString * server;//": "重量:250g;口味:辣"
@property (nonatomic, copy) NSString * server_else;//":"1开发票 0 不开发票"
@property (nonatomic, copy) NSString * integrity_d;//":"发票名称"
@property (nonatomic, copy) NSString * integrity_a;//":"发票运费"
@property (nonatomic, copy) NSString * integrity_b;//":"系统自动收货时间"
@property (nonatomic, copy) NSString * integrity_c;//":"0没退钱  1已退钱";
@property (nonatomic, copy) NSString * is_back_apply;//":""税金运费
@property (nonatomic, copy) NSString * after_sale_status;//积分价格

@property (nonatomic, copy) NSString * after_sale_type;//": "",              // 收货时间
@property (nonatomic, copy) NSString * g_delay_time;//": "1",              // 是否已延长收货（0->否，1->是）
@property (nonatomic, copy) NSString * is_invoice;//": "1",              // 是否存在售后（0->不存在，1->存在）
@property (nonatomic, copy) NSString * invoice_name;//1支持七天无理由退换货
@property (nonatomic, copy) NSString * express_fee;//": "放弃此商品七天无理由退换货？",              // 确认收货提示框内容
@property (nonatomic, copy) NSString * tax_pay;//": "注：七天后将自动收货",                    // 确认收货提示框注释内容
@property (nonatomic, copy) NSString * welfare;//": "0",
@property (nonatomic, copy) NSString * sale_status;//";//: "0",
@property (nonatomic, copy) NSString * sure_delivery_time;//": "0",
@property (nonatomic, copy) NSString * order_goods_id;//": "0",
@property (nonatomic, copy) NSString * comment_status;//": "爱此山水果燕麦片",            //商品名
@property (nonatomic, copy) NSString * refund_price;//": "1",                                          //商品id
@property (nonatomic, copy) NSString * return_integral;//": "http://wjyp.txunda.com/Uploads/Goods/2017-11-30/5a1ff870cf38b.jpg"        //商品图
@property (nonatomic, copy) NSString * back_apply_id;




@property (nonatomic, copy) NSString * goods_name;//":"//1->已收货，0->未收货
@property (nonatomic, copy) NSString * market_price;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * shop_price;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * goods_num;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * goods_id;//
@property (nonatomic, copy) NSString * is_active;//":"//0未提醒发货   1以提醒发货"
@property (nonatomic, copy) NSString * auto_time;//":""返回积分数
/*
 *  是无界商店制品的信息id  记录每个制品用多少积分之类的
 */
@property (nonatomic, copy) NSString * goods_img;

@property (nonatomic, copy) NSString * attr;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * status;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * remind_status;//
@property (nonatomic, copy) NSString * after_type;//":"//0未提醒发货   1以提醒发货"
@property (nonatomic, copy) NSString * is_sales;//":""返回积分数
/*
 *  是无界商店制品的信息id  记录每个制品用多少积分之类的
 */
@property (nonatomic, copy) NSString * gift_goods_id;
@property (nonatomic, copy) NSString * use_voucher;






- (void)SgiftOderDetailModelSuccess:(SgiftOderDetailModelSuccessBlock)success andFailure:(SgiftOderDetailModelFailureBlock)failure;
@end
