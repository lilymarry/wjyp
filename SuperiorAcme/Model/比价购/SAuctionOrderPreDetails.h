//
//  SAuctionOrderPreDetails.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionOrderPreDetailsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAuctionOrderPreDetailsFailureBlock) (NSError * error);

@interface SAuctionOrderPreDetails : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

@property (nonatomic, strong) SAuctionOrderPreDetails * data;
@property (nonatomic, copy) NSString * pay_retainage_money;//": "0.00",        //支付尾款时间
@property (nonatomic, copy) NSString * pay_money;//": "10.00",                       //一口价支付金额
@property (nonatomic, copy) NSString * buy_type;//": "0",                                //购买方式：0->一口价；1->竞拍
@property (nonatomic, copy) NSString * pay_deposit_money;//": "0.00",           //支付定金金额
@property (nonatomic, copy) NSString * pay_retainage_time;//": "0",                 //支付尾款时间
@property (nonatomic, copy) NSString * pay_deposit_time;//": "0",                    //支付定金时间
@property (nonatomic, copy) NSString * logistics;//": "您的订单待配货",           //物流信息
@property (nonatomic, copy) NSString * logistics_time;//": "2017-12-7 11:11:11",           //物流更新时间
@property (nonatomic, copy) NSString * user_name;//": "南山南",                      //用户名
@property (nonatomic, copy) NSString * order_status;//": "0",                        //订单状态
//@property (nonatomic, copy) NSString * buy_type;//": "1",            //订单类型（0->一口价，1->竞拍）
@property (nonatomic, copy) NSString * phone;//": "15139098804",             //手机号
@property (nonatomic, copy) NSString * address;//": "天津天津南开区迎水道街道华苑鑫茂科技园1栋1809室",          //地址
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",              // 店铺名
@property (nonatomic, copy) NSString * leave_message;//": "",                               //留言
@property (nonatomic, copy) NSString * order_sn;//": "151281047426196",      // 订单号
@property (nonatomic, copy) NSString * create_time;//": "2017-12-09 17:07:54",         //创建时间
@property (nonatomic, copy) NSString * pay_time;//支付时间
@property (nonatomic, copy) NSString * order_price;
@property (nonatomic, copy) NSString * freight;//"   // 运费
@property (nonatomic, copy) NSString * express_company;//"   // 快递公司名
@property (nonatomic, copy) NSString * express_no;//"           // 快递单号

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * sure_delivery_time;//": "",              // 收货时间
@property (nonatomic, copy) NSString * sale_status;//": "1",              // 是否已延长收货（0->否，1->是）
@property (nonatomic, copy) NSString * after_sale_type;//": "1",              // 是否存在售后（0->不存在，1->存在）
@property (nonatomic, copy) NSString * sure_status;//1支持七天无理由退换货
@property (nonatomic, copy) NSString * server;//": "放弃此商品七天无理由退换货？",              // 确认收货提示框内容
@property (nonatomic, copy) NSString * server_else;//": "注：七天后将自动收货",                    // 确认收货提示框注释内容
@property (nonatomic, copy) NSString * order_goods_id;//":"1" //订单商品id
@property (nonatomic, copy) NSString * goods_name;//": "糖果礼盒 小朋友的最爱",          //商品名
@property (nonatomic, copy) NSString * goods_num;//": "1",                                           //商品数量
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b675d410c.jpg",    //商品图
@property (nonatomic, copy) NSString * attr;//": "测试属性值:3"                        //商品属性
@property (nonatomic, copy) NSString * after_type;//":"0" //商品退货状态 0正常 1退货 2退款成功
@property (nonatomic, copy) NSString * back_apply_id;//  订单详情每个商品   售后id
@property (nonatomic, copy) NSString * is_sales;//  订单详情每个商品   商家是否同意退货，（0不同意 1同意）

- (void)sAuctionOrderPreDetailsSuccess:(SAuctionOrderPreDetailsSuccessBlock)success andFailure:(SAuctionOrderPreDetailsFailureBlock)failure;
@end
