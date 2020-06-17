//
//  SAuctionOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAuctionOrderOrderListFailureBlock) (NSError * error);

@interface SAuctionOrderOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态 竞拍中=>10; 竞拍成功=>11; 竞拍结束=>12; 待付尾款=>1; /*待付定金=>2;*/ 待发货=>3; 待收货=>4; 待评价=>8 ; 已完成=>6; 已取消=>5; 已删除=>9 ; 全部订单=>15；待付一口价=>7 ；已完成=>13
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * buy_type;//": "1",            //订单类型（0->一口价，1->竞拍）
@property (nonatomic, copy) NSString * order_id;//": "1",            //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",      //竞拍中=>10; 竞拍成功=>11; 竞拍结束=>12; 待付尾款=>1; 待付定金=>2; 待发货=>3; 待收货=>4; 待评价=>5 ; 已完成=>6; 已取消=>5; 已删除=>9 ; 全部订单=>15；待付一口价=>7
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",      //店铺名称
@property (nonatomic, copy) NSString * goods_id;//": "11",                 //商品id
@property (nonatomic, copy) NSString * order_price;//";: "10.00",                                 //总金额
@property (nonatomic, copy) NSString * end_time;//": "2017-12-11 20:10:43"           //竞拍结束时间
@property (nonatomic, copy) NSString * goods_num;//": "1",                                          //商品数量
@property (nonatomic, copy) NSString * start_price;//";: "10.00",                                 //起拍价
@property (nonatomic, copy) NSString * freight;//"   // 运费;

@property (nonatomic, copy) NSArray * order_goods;
//@property (nonatomic, copy) NSString * goods_id;//": "1",
@property (nonatomic, copy) NSString * goods_name;//": "糖果礼盒 小朋友的最爱",           //商品名称
//@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",
//@property (nonatomic, copy) NSString * goods_num;//": "1",                                          //商品数量
@property (nonatomic, copy) NSString * goods_attr;//": "测试属性值:3",                        //商品属性
@property (nonatomic, copy) NSString * goods_img;//": "10877",
@property (nonatomic, copy) NSString * pic;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b675d410c.jpg"                //商品图
@property (nonatomic, copy) NSString * shop_price;//商品金额

- (void)sAuctionOrderOrderListSuccess:(SAuctionOrderOrderListSuccessBlock)success andFailure:(SAuctionOrderOrderListFailureBlock)failure;
@end
