//
//  SCarOrderCommentPage.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderCommentPageSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCarOrderCommentPageFailureBlock) (NSError * error);

@interface SCarOrderCommentPage : NSObject
@property (nonatomic, copy) NSString * order_id;//    评价界面

@property (nonatomic, strong) SCarOrderCommentPage * data;
@property (nonatomic, copy) NSString * car_img;//": "http://wjyp.txunda.com/Uploads/CarBuy/2017-09-19/59c0b1324fc8e.png",//图片
@property (nonatomic, copy) NSString * car_name;//": "宝马x6 -- 惠安",//车名称
@property (nonatomic, copy) NSString * pre_money;//": "99.00",//优惠券金额
@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * goods_price;//": "99.00",//优惠券总价
@property (nonatomic, copy) NSString * order_price;//": "99.00",//订单总价
@property (nonatomic, copy) NSString * true_pre_money;//": "200.00",//可抵扣金额
@property (nonatomic, copy) NSString * all_price;//": "500000.00",//车全价
//评价标签
@property (nonatomic, copy) NSArray * label_list;
@property (nonatomic, copy) NSString * label_id;//": "2",//标签ID
@property (nonatomic, copy) NSString * car_label;//": "外观漂亮"//标签
@property (nonatomic, assign) BOOL label_BOOL;

- (void)sCarOrderCommentPageSuccess:(SCarOrderCommentPageSuccessBlock)success andFailure:(SCarOrderCommentPageFailureBlock)failure;
@end
