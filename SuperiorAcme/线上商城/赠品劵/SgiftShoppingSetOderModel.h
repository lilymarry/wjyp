//
//  SgiftShoppingSetOderModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SgiftShoppingSetOderModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SgiftShoppingSetOderModelFailureBlock) (NSError * error);

@interface SgiftShoppingSetOderModel : NSObject
@property (nonatomic, copy) NSString * address_id;//    地址id    否    文本    1
@property (nonatomic, copy) NSString * goods_num;//    商品数量
@property (nonatomic, copy) NSString * order_id;//": "7",            //订单id
@property (nonatomic, copy) NSString * goods;
@property (nonatomic, copy) NSString * leave_message;//留言
@property (nonatomic, copy) NSString * invoice;//json , 请按顺序传入！！！[{"发票类型id":"1","发票抬头（1->个人，2->公司）":"1","发票抬头名":"name","发票明细":"detail","发票id":"1","识别号”:1111,"是否开发票（1->是，0->否）”:1},{"t_id":"1","rise":"1","rise_name":"name","invoice_detail":"detail","invoice_id":"3",,"recognition”:1111,"is_invoice”:1}]    否
@property (nonatomic, copy) NSString * order_type;//    无界商店id    否    文本    1

@property (nonatomic, strong) SgiftShoppingSetOderModel * data;
//@property (nonatomic, copy) NSString * order_id;//    无界商店id    否    文本
@property (nonatomic, copy) NSString * order_price;//    运费金额    否    文本    1
@property (nonatomic, copy) NSString * merchant_name;//    快递名称
//@property (nonatomic, copy) NSString * goods_num;//": "7",            //商品数量
@property (nonatomic, copy) NSString * merchant_id;//": 1,           //是否可使用积分
@property (nonatomic, copy) NSString * goods_name;//": 30,        //订单需要积分数
@property (nonatomic, copy) NSString * integral;//": "得一蜂业旗舰店",      //店铺名称
//@property (nonatomic, copy) NSString * order_type;//": "1",         //店铺id
//@property (nonatomic, copy) NSString * integral;//": "598.50"       //我的积分
//@property (nonatomic, copy) NSString * shipping_id;//物流公司id
//
//@property (nonatomic, copy) NSString * red_return_integral;//会员优惠描述
//
//
//@property (nonatomic, copy) NSString * integralBuy_id;//    无界商店id    否    文本
//@property (nonatomic, copy) NSString * freight;//    运费金额    否    文本    1
//@property (nonatomic, copy) NSString * freight_type;//    快递名称



//@property (nonatomic, copy) NSString * goods_num;//": "7",            //商品数量
//@property (nonatomic, copy) NSString * is_integral;//": 1,           //是否可使用积分
//@property (nonatomic, copy) NSString * order_price;//": 30,        //订单需要积分数
//@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",      //店铺名称
//@property (nonatomic, copy) NSString * merchant_id;//": "1",         //店铺id
//@property (nonatomic, copy) NSString * integral;//": "598.50"       //我的积分
//@property (nonatomic, copy) NSString * shipping_id;//物流公司id

//@property (nonatomic, copy) NSString * red_return_integral;//会员优惠描述
- (void)SgiftShoppingSetOderSuccess:(SgiftShoppingSetOderModelSuccessBlock)success andFailure:(SgiftShoppingSetOderModelFailureBlock)failure;
@end

