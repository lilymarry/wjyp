//
//  SOrderOrderLogistics.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderOrderLogisticsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOrderOrderLogisticsFailureBlock) (NSError * error);

@interface SOrderOrderLogistics : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "订单相关的订单商品ID",
@property (nonatomic, copy) NSString * trans_type;//": "运输方式 1快递 2EMS 3平邮 4物流",
@property (nonatomic, copy) NSString * express_no;//": "物流单号"
@property (nonatomic, copy) NSString * express_company;//": "快递ID",
@property (nonatomic, copy) NSString * goods_img;//": "图片"
@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
@property (nonatomic, copy) NSString * attr;//": "商品属性"
@property (nonatomic, copy) NSString * shop_price;//": "商品金额",
@property (nonatomic, copy) NSString * goods_num;//": "商品数量"
@property (nonatomic, copy) NSString * shipping_name;//":"快递公司名称"

@property (nonatomic, copy) NSString * order_type;//商品类型
@property (nonatomic, copy) NSString * is_active;//0:普通商品 2:399分销商品


- (void)sOrderOrderLogisticsSuccess:(SOrderOrderLogisticsSuccessBlock)success andFailure:(SOrderOrderLogisticsFailureBlock)failure;
@end
