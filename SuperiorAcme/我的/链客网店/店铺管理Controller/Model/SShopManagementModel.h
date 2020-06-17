//
//  SShopManagementModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
typedef void(^SShopManagementModelSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SShopManagementModelFailureBlock) (NSError * error);

@interface SShopManagementModel : BaseModel

#pragma mark - 既作为接口返回值,也作为想借口发送的参数
@property (nonatomic, copy) NSString * id;//店铺id
@property (nonatomic, copy) NSString * shop_name;//店铺名称
@property (nonatomic, copy) NSString * shop_desc;//店铺描述

#pragma mark - 接口返回的数据
@property (nonatomic, copy) NSString * shop_pic;//店铺头像
@property (nonatomic, copy) NSString * shop_url;//店铺头像的url
@property (nonatomic, copy) NSString * user_id;//小店店主id
@property (nonatomic, copy) NSString * set_id;//小店等级id
@property (nonatomic, copy) NSString * shop_status;//小店的状态 (0正常, 9删除)
@property (nonatomic, copy) NSString * pay_money;//付款金额数
@property (nonatomic, copy) NSString * pay_orders;//付款订单数
@property (nonatomic, copy) NSString * visit_nums;//小店访问数
@property (nonatomic, copy) NSString * create_time;//创建时间
@property (nonatomic, copy) NSString * update_time;//更新时间
@property (nonatomic, copy) NSString * other;

@property (nonatomic, copy) NSString * end_time;
@property (nonatomic, copy) NSString * is_vip;
@property (nonatomic, copy) NSString * open_time;
@property (nonatomic, copy) NSString * path;
@property (nonatomic, copy) NSString * ticket_lines;



#pragma mark - 向接口发送的参数
@property (nonatomic, strong) UIImage * shopIconImage;


//获取店铺的信息
+ (void)getShopMessageWithShopID:(NSString *)shopid andSuccess:(SShopManagementModelSuccessBlock)success andFailure:(SShopManagementModelFailureBlock)failure;
@end
