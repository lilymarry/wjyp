//
//  SLimitBuyOrderShoppingCart.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderShoppingCartSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SLimitBuyOrderShoppingCartFailureBlock) (NSError * error);

@interface SLimitBuyOrderShoppingCart : NSObject
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    1
@property (nonatomic, copy) NSString * num;//    数量    否    文本    1
@property (nonatomic, copy) NSString * product_id;//    组和属性id    否    文本    1
@property (nonatomic, copy) NSString * merchant_id;//    商家id

@property (nonatomic, strong) SLimitBuyOrderShoppingCart * data;
@property (nonatomic, copy) NSString * address_id;//": "4",//地址id
@property (nonatomic, copy) NSString * receiver;//": "GYM",//收货人
@property (nonatomic, copy) NSString * phone;//": "18600001234",//联系电话
@property (nonatomic, copy) NSString * address;//": "天津市南开区华苑鑫茂科技园",//地址
@property (nonatomic, copy) NSString * province;//": "天津",//省
@property (nonatomic, copy) NSString * city;//": "天津市",//市
@property (nonatomic, copy) NSString * area;//": "南开区",//区
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",//店铺名称
@property (nonatomic, copy) NSString * is_default;//" :"1"//是否有默认地址 1是0否
@property (nonatomic, copy) NSString * sum_shop_price;//":"100" //商品总额
@property (nonatomic, copy) NSString * discount;//": 9.25,//红色代金券抵扣金额(金额)
@property (nonatomic, copy) NSString * yellow_discount;//": 9.25,//黄色代金券抵扣金额(金额)
@property (nonatomic, copy) NSString * blue_discount;//": 9.25,//蓝色代金券克扣金额(金额)
@property (nonatomic, copy) NSString * sum_discount;//": 27.75//总抵扣金额(金额)

@property (nonatomic, copy) NSArray * item;
@property (nonatomic, copy) NSString * goods_attr_first;//": "粉,L",         //商品属性
//@property (nonatomic, copy) NSString * goods_id;//": "13",//商品id
@property (nonatomic, copy) NSString * goods_name;//": "美式球形爆米花 香甜酥脆到爆 看片好伙伴 休闲零食小吃",//商品名称
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b9c3370d7.jpg",//商品封面图
//@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * shop_price;//": "26.60",//价格
//@property (nonatomic, copy) NSString * product_id;//":"1"//组和属性id

- (void)sLimitBuyOrderShoppingCartSuccess:(SLimitBuyOrderShoppingCartSuccessBlock)success andFailure:(SLimitBuyOrderShoppingCartFailureBlock)failure;
@end
