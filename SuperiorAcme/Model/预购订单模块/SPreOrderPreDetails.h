//
//  SPreOrderPreDetails.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreOrderPreDetailsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SPreOrderPreDetailsFailureBlock) (NSError * error);

@interface SPreOrderPreDetails : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

@property (nonatomic, strong) SPreOrderPreDetails * data;
@property (nonatomic, copy) NSString * user_name;//": "哈哈哈",                  // 用户名
@property (nonatomic, copy) NSString * order_status;//": "0",                       // 订单状态
@property (nonatomic, copy) NSString * phone;//": "15837925623",           // 手机号
@property (nonatomic, copy) NSString * start;//": 1,                                    // 定金
@property (nonatomic, copy) NSString * end;//": 4,                                   // 尾款
@property (nonatomic, copy) NSString * start_integral;//”：999                        // 定金积分
@property (nonatomic, copy) NSString * final_integral;//”：999                        // 尾款积分
@property (nonatomic, copy) NSString * address;//": "天津天津南开区迎水道街道华苑鑫茂科技园1栋B座1809",       // 地址
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",                   // 店铺名
@property (nonatomic, copy) NSString * leave_message;//": "",                                                // 留言
@property (nonatomic, copy) NSString * order_price;//": "5.00",                                          //总金额
@property (nonatomic, copy) NSString * order_sn;//": "151263400058526",                        // 订单号
@property (nonatomic, copy) NSString * create_time;//": "2017-12-07 16:06:40",              // 创建时间
@property (nonatomic, copy) NSString * pay_time;//": "1970-01-01 08:00:00",                 // 支付时间
//@property (nonatomic, copy) NSString * order_sn;//": "151253170291037",                              // 订单号
@property (nonatomic, copy) NSString * logistics;//":您的订单待配货                                       // 物流状态
@property (nonatomic, copy) NSString * logistics_time;//时间
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
@property (nonatomic, copy) NSString * goods_name;//": "自制DIY微波爆米花 随时自己来一包 就是香脆",         //商品名
@property (nonatomic, copy) NSString * shop_price;//": "5",                                                // 单价
@property (nonatomic, copy) NSString * goods_num;//": "1",                                               // 数量
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-11-30/5a1ffaaf89456.jpg",   // 图片
@property (nonatomic, copy) NSString * attr;//": "\"\""   //属性
@property (nonatomic, copy) NSString * after_type;//":"0" //商品退货状态 0正常 1退货 2退款成功
@property (nonatomic, copy) NSString * back_apply_id;//  订单详情每个商品   售后id
@property (nonatomic, copy) NSString * is_sales;//  订单详情每个商品   商家是否同意退货，（0不同意 1同意）

- (void)sPreOrderPreDetailsSuccess:(SPreOrderPreDetailsSuccessBlock)success andFailure:(SPreOrderPreDetailsFailureBlock)failure;
@end
