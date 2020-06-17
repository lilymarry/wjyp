//
//  SPreOrderPreOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreOrderPreOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SPreOrderPreOrderListFailureBlock) (NSError * error);

@interface SPreOrderPreOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态（ '0': '预购中' ； '1': '待付尾款' ；'2': '待发货；'3': '待收货；‘4’：待评价；‘5’：‘已取消’；‘6’：已完成；‘7’ ：待付定金） 默认9（全部）    否    文本    9
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "4",                                          //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",                                  //订单状态（ '0': '预购中' ； '1': '待付尾款' ；'2': '待发货；'3': '待收货；‘4’：待评价；‘5’：‘已取消’；‘6’：已评价）
@property (nonatomic, copy) NSString * merchant_name;//": "爱家源环保专卖店",    //店铺名称
@property (nonatomic, copy) NSString * order_price;//": "88.00",                          //订单总价
@property (nonatomic, copy) NSString * start;//": 1,                                             // 定金
@property (nonatomic, copy) NSString * end;//": 4                                              // 尾款
@property (nonatomic, copy) NSString * freight;//"   // 运费;

@property (nonatomic, copy) NSArray * order_goods;
//@property (nonatomic, copy) NSString * order_id;//": "4",
@property (nonatomic, copy) NSString * goods_name;//": "时尚保温杯 持久保温 简约时尚 金属材质 水杯杯子",
//@property (nonatomic, copy) NSString * merchant_name;//": "爱家源环保专卖店",
@property (nonatomic, copy) NSString * shop_price;//": "88.00",
@property (nonatomic, copy) NSString * goods_num;//": "1",
@property (nonatomic, copy) NSString * goods_attr;//": "",
@property (nonatomic, copy) NSString * goods_img;//": "10911",
@property (nonatomic, copy) NSString * pic;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20be2243899.jpg"

- (void)sPreOrderPreOrderListSuccess:(SPreOrderPreOrderListSuccessBlock)success andFailure:(SPreOrderPreOrderListFailureBlock)failure;
@end
