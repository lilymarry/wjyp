//
//  SHouseOrderCommentPage.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderCommentPageSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseOrderCommentPageFailureBlock) (NSError * error);

@interface SHouseOrderCommentPage : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

@property (nonatomic, strong) SHouseOrderCommentPage * data;
@property (nonatomic, copy) NSString * house_name;//": "棠颂别墅",//楼盘清楚
@property (nonatomic, copy) NSString * all_price;//": "0",//房全款
@property (nonatomic, copy) NSString * sell_address;//": "天晶石北辰区董总快速",//楼盘地址
@property (nonatomic, copy) NSString * style_name;//": "棠颂别墅 三室一厅",//户型名称
@property (nonatomic, copy) NSString * house_style_img;//": "http://wjyp.txunda.com/Uploads/HouseStyle/2017-11-27/5a1bb5e124ae1.png",//户型图片
@property (nonatomic, copy) NSString * tags;//": "大户型,在售,独栋",//户型标签
@property (nonatomic, copy) NSString * one_price;//": "12000.01",//房价
@property (nonatomic, copy) NSString * pre_money;//": "99.00",//代金券金额
@property (nonatomic, copy) NSString * true_pre_money;//": "500.00",//抵扣金额
@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * goods_price;//": "990.00",//代金券总价
@property (nonatomic, copy) NSString * order_price;//": "990.00",//订单总价
//标签列表
@property (nonatomic, copy) NSArray * label_list;
@property (nonatomic, copy) NSString * label_id;//": "1",//标签ID
@property (nonatomic, copy) NSString * house_label;//": "户型完美"//标签
@property (nonatomic, assign) BOOL label_BOOL;

- (void)sHouseOrderCommentPageSuccess:(SHouseOrderCommentPageSuccessBlock)success andFailure:(SHouseOrderCommentPageFailureBlock)failure;
@end
