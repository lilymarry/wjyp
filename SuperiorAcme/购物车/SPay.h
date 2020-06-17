//
//  SPay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SPay_BackBlock) ();

@interface SPay : UIViewController
@property (nonatomic, assign) BOOL type;//NO订单支付 YES会员支付

@property (nonatomic, copy) NSString * model_type;//中文类型：汽车购、房产购、普通商品、拼单购、无界预购、积分抽奖、比价购、比价购保证金、线下商铺
@property (nonatomic, copy) NSString * car_id;//汽车购ID
@property (nonatomic, copy) NSString * num;//购买数量
@property (nonatomic, copy) NSString * order_id;//订单付款
@property (nonatomic, copy) NSString * goods_Json;//搭配购:goods_Json


/*
 * 普通商品所需参数
 */
@property (nonatomic, copy) NSString * address_id;//    地址id    否    文本    1
@property (nonatomic, copy) NSString * goods_num;//    商品数量(直接购买时传)    否    文本    1
@property (nonatomic, copy) NSString * goods_id;//    商品id(直接购买时传)    是    文本    1
@property (nonatomic, copy) NSString * product_id;//    商品属性id(直接购买时传)    否    文本    1
@property (nonatomic, copy) NSString * invoice;//json , 请按顺序传入！！！[{"发票类型id":"1","发票抬头（1->个人，2->公司）":"1","发票抬头名":"name","发票明细":"detail","发票id":"1","识别号”:1111,"是否开发票（1->是，0->否）”:1},{"t_id":"1","rise":"1","rise_name":"name","invoice_detail":"detail","invoice_id":"3",,"recognition”:1111,"is_invoice”:1}]
@property (nonatomic, copy) NSString * leave_message;//留言
@property (nonatomic, copy) NSString * goods;//json格式普通商品下单（单商品）参数：[{"属性id":"91","商品id":"43","配送方式id":"11","配送方式类型:"1","快递公司ID":"1","邮费":"1","快递类型":"平邮","描述":" ","相同模板的商品ID":"1,2,3"}][{"product_id":"91","goods_id":"43","tem_id": "4","type_status": 1, "shipping_id": "35","pay": "10","type": "平邮","desc": "满6.000KG满7.00元包邮","same_tem_id": "308,98"}]购物车商品下单（多商品）参数：[{"购物车id":"91","配送方式id":"11","配送方式类型:"1","快递公司ID":"1","邮费":"1","快递类型":"平邮","描述":" ","相同模板的商品ID":"1,2,3"}][{"cate_ids":"91","tem_id": "4","type_status": 1, "shipping_id": "35","pay": "10","type": "平邮","desc": "满6.000KG满7.00元包邮","same_tem_id": "308,98"}]

/*
 * 拼单购所需参数
 */
@property (nonatomic, copy) NSString * special_type_sub;//1直接购买 2拼单(开团) 3拼单(参团)
@property (nonatomic, copy) NSString * group_buy_id;//团购id(直接购买、开团、拼团都要传)
@property (nonatomic, copy) NSString * group_buy_order_id;//团购订单id(参团时传)
@property (nonatomic, copy) NSString * shipping_id;//物流公司id
/*
 * 无界预购所需参数
 */
@property (nonatomic, copy) NSString * pre_id;//    预购id

/*
 * 限量购所需参数
 */
@property (nonatomic, copy) NSString * limit_buy_id;//    限量购id
@property (nonatomic, copy) NSString * limit_buy_order_id;//    限量购订单id(订单列表支付时传)

/*
 * 积分抽奖所需参数
 */
@property (nonatomic, copy) NSString * integral_id;//    一元购id
@property (nonatomic, assign) BOOL add_integral_isno;//是否追加 下单不需要

/*
 * 比价购保证金所需参数
 */
@property (nonatomic, copy) NSString * base_money;//": "1.00",   // 保证金金额
@property (nonatomic, copy) NSString * base_balance;//"    //余额
@property (nonatomic, copy) NSString * base_merchant_name;//": "",      //店铺名称

/*
 * 比价购所需参数
 */
@property (nonatomic, copy) NSString * auction_id;//    竞拍id(直接购买时传)（一口价）
@property (nonatomic, assign) BOOL auction_isno;//购买类型(直接购买时传)：YES->一口价；NO->竞拍（一口价）

/*
 * 无界商店所需参数
 */
@property (nonatomic, copy) NSString * integralBuy_id;//    无界商店id

/*
 * 线下商铺所需参数
 */
@property (nonatomic, copy) NSString *merchant_id;  //店铺ID
@property (nonatomic, copy) NSString *pay_money;    //支付金额
@property (nonatomic, assign) BOOL isPopRootVC;     //区分是不是订单页进来的调用这个
                                                    //目前是线下商铺

@property (nonatomic, copy) SPay_BackBlock SPay_Back;

@property (nonatomic, copy) NSString *is_active;   // 是否是 2980商品
//@property (nonatomic, assign) BOOL is399Norm;
//@property (nonatomic, assign) BOOL is399;

@property (nonatomic, assign) BOOL IsInShop;//399商品

@property (nonatomic, assign) BOOL  IsSuiPian;//碎片订单
@property (nonatomic, assign) BOOL  IsSuiPianWeb;//碎片网页
@end
