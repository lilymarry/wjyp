//
//  GCustomerService.h
//  SeaMonkey
//
//  Created by TXD_air on 16/10/31.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOrderInfor.h"

@interface GCustomerService : UIViewController

//@property (nonatomic, copy) NSString * type;//0:售后 1：退款
@property (nonatomic, copy) NSString * thisMoney;//退款金额
@property (nonatomic, copy) NSString * thisMoney_num;//退款个数
@property (nonatomic, copy) NSString * order_id;//订单ID
@property (nonatomic, copy) NSString * order_type;//    类型 1普通订单 2拼单购 3无界预购 4比价购 5积分抽奖  (5无界商店)
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品表id

@property (nonatomic, strong) SOrderInfor * inforBlock;
@end
