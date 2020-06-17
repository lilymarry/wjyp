//
//  SMemberOrderInfor.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEvaUnderLineShopVC.h"

@interface SMemberOrderInfor : UIViewController
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * member_coding;

@property (nonatomic, copy) NSString * type;//会员卡 充值 线下商铺

/*
 *无界商铺订单详情相关的参数,还有一个order_id
 */
@property (nonatomic, copy) NSString * merchant_id;//商家id
@property (nonatomic, copy) NSString * pay_status;//支付状态 //0未支付,1已支付
@property (nonatomic, copy) NSString * status;//订单状态   //0正常,5取消订单
@property (nonatomic, assign)BOOL common_status; //是否评论过  1隐藏

/*
 跳转详情
 
 SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
 infor.order_id = list.order_id;
 infor.type = @"线下商铺";
 infor.pay_status = @"1";
 infor.common_status = 1;
 infor.status = @"10086";
 [self.navigationController pushViewController:infor animated:YES];
 
 */




@end
