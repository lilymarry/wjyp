//
//  SGoodsAttrApi.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsAttrApiSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGoodsAttrApiFailureBlock) (NSError * error);

@interface SGoodsAttrApi : NSObject
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    1
@property (nonatomic, copy) NSString * product_id;//    商品属性id （特殊商品时需传）

@property (nonatomic, strong) SGoodsAttrApi * data;
@property (nonatomic, copy) NSString * is_attr;//"    //是否有商品属性 0->没有   1->有


@property (nonatomic, copy) NSArray * first_list;
@property (nonatomic, copy) NSString * first_list_name;//": "颜色",           // 属性名
@property (nonatomic, copy) NSArray * first_list_val;
@property (nonatomic, copy) NSString * val;//": "红色"             // 属性值
@property (nonatomic, copy) NSString * val_isno;//nil未选中 @"1"选中 @"2"库存不足

@property (nonatomic, copy) NSArray * first_val;
@property (nonatomic, copy) NSString * id;//": "118",             // 商品属性id
//@property (nonatomic, copy) NSString * goods_id;//": "59",        // 商品id
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp/Uploads/Product/2017-12-22/5a3ccf3a53b2d.png",   // 商品图
@property (nonatomic, copy) NSString * arrtValue;//": "红+L+工装"           // 商品属性
@property (nonatomic, copy) NSString * goods_num;//"                   // 库存
@property (nonatomic, copy) NSString * max_num;//"                   //最大限购数
@property (nonatomic, copy) NSString * shop_price;//”                  //售价
@property (nonatomic, copy) NSString * market_price;//”                  //市场价
@property (nonatomic, copy) NSString * settlement_price;//”                  //结算价
@property (nonatomic, copy) NSString * red_return_integral;//”                  //返回积分
@property (nonatomic, copy) NSString * integral;//"//积分价格
@property (nonatomic, copy) NSString * discount;//": "本产品最多可以使用50%红券抵扣现金",
//@property (nonatomic, copy) NSString * red_return_integral;//": "0.00",       //红券返回积分
@property (nonatomic, copy) NSString * yellow_discount;//": "本产品最多可以使用25%黄券抵扣现金",
@property (nonatomic, copy) NSString * blue_discount;//": "本产品最多可以使用25%蓝券抵扣现金",
@property (nonatomic, copy) NSString * wy_price;//": "0.00",                        //无忧价
@property (nonatomic, copy) NSString * yx_price;//": "0.00",                         //优享价
@property (nonatomic, copy) NSArray * dj_ticket;
@property (nonatomic, copy) NSString * type;//": 1,             //类型 1红券  2黄券 3蓝券
@property (nonatomic, copy) NSString * discount_desc;//": "本产品最多可以使用3000%红券抵扣现金"       //描述
@property (nonatomic, copy) NSString *buy_goods_type;//商品类型
@property (nonatomic, copy) NSString *group_buy_id;//拼单购 选中商品规格的ID
@property (nonatomic, copy) NSString *group_buy_type_status;// 拼单购状态下 如果是体验商品 传1 否则传2

/*
 *普通商品的价格
 */
@property (nonatomic, copy) NSString * p_shop_price;//拼单商品,对应的正常商品的实际价格

/*****这个属性暂时不用*****/
@property (nonatomic, copy) NSString * group_price;//拼单商品的价格

/*
 *对应的普通商品返还的积分
 */
@property (nonatomic, copy) NSString * p_integral;//原商品积分

/*
 *添加无界商店商品需要的字段属性
 */
#pragma mark - 无界商城
@property (nonatomic, copy) NSString * use_integral;//积分价格
@property (nonatomic, copy) NSString * integral_buy_id;//无界商店商品id



//赠品专区
@property (nonatomic, copy) NSString * use_voucher;
@property (nonatomic, copy) NSString * sell_num;
@property (nonatomic, copy) NSString * price_id;
@property (nonatomic, copy) NSString * gift_goods_id;
@property (nonatomic, copy) NSString * wy_price_special;//"                   // 库存
@property (nonatomic, copy) NSString * yx_price_special;//"                   //最大限购数
@property (nonatomic, copy) NSString * special_id;//”                  //结算价
@property (nonatomic, copy) NSString * special_name;//”                  //返回积分
@property (nonatomic, copy) NSString * special;//"//积分价格
@property (nonatomic, copy) NSString * special_time;//": "本产品最多可以使用50%红券抵扣现金",
//@property (nonatomic, copy) NSString * red_return_integral;//": "0.00",       //红券返回积分
@property (nonatomic, copy) NSString * examine_id;//": "本产品最多可以使用25%黄券抵扣现金",
@property (nonatomic, copy) NSString * examine_time;//": "本产品最多可以使用25%蓝券抵扣现金",
@property (nonatomic, copy) NSString * examine;//": "0.00",                        //无忧价
@property (nonatomic, copy) NSString * arrtValue_andr;

- (void)sGoodsAttrApiSuccess:(SGoodsAttrApiSuccessBlock)success andFailure:(SGoodsAttrApiFailureBlock)failure;
@end
