//
//  CustomerServiceInfor.h
//  TaoMiShop
//
//  Created by TXD_air on 16/10/22.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOrderInfor.h"

@interface CustomerServiceInfor : UIViewController
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品id
@property (nonatomic, copy) NSString * back_apply_id;//    售后id
@property (nonatomic, copy) NSString * is_sales;//  订单详情每个商品   商家是否同意退货，（0不同意 1同意）
@property (nonatomic, copy) NSString * after_type;//":"0" //商品退货状态 0正常 1退货 2退款成功    传这个参数是要隐藏所有操作，只可以浏览(状态2)
@property (nonatomic, copy) NSString * refund_price;//售后金额
@property (nonatomic, copy) NSString * order_id;

@property (nonatomic, copy) NSString * order_type;//商品类型

@property (nonatomic, strong) SOrderInfor * inforBlock;
@end
