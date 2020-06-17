//
//  SOrderCommentindex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderCommentindexSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOrderCommentindexFailureBlock) (NSError * error);

@interface SOrderCommentindex : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id
@property (nonatomic, copy) NSString * order_type;//    订单类型 1普通订单 2拼单购 3无界预购 4比价购 5无界商店

@property (nonatomic, strong) SOrderCommentindex * data;
@property (nonatomic, copy) NSString * merchant_star;//": "", //店铺评分
@property (nonatomic, copy) NSString * delivery_star;//": "", //物流评分
@property (nonatomic, copy) NSString * order_status;//": 0, //订单评价状态 1已评价 0未评级

@property (nonatomic, copy) NSArray * goods_list;
@property (nonatomic, copy) NSString * order_goods_id;//": "170",//订单商品表id
@property (nonatomic, copy) NSString * goods_id;//": "13",//商品id
@property (nonatomic, copy) NSString * goods_name;//": "美式球形爆米花 香甜酥脆到爆 看片好伙伴 休闲零食小吃",//商品名
@property (nonatomic, copy) NSString * product_id;//": "0",//属性id
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b9c3370d7.jpg",//封面图
@property (nonatomic, copy) NSString * merchant_id;//": "1",//商家id
@property (nonatomic, copy) NSString * status;//": "1",//商品评价状态 1已评价 0未评价
@property (nonatomic, copy) NSString * all_star;//": "5",//综合评分
@property (nonatomic, copy) NSString * content;//": "123456",//评论内容
@property (nonatomic, assign) BOOL pictures_isno;

@property (nonatomic, copy) NSArray * pictures;
@property (nonatomic, copy) NSString * path;//": "http://wjyp.txunda.com/Uploads/Goods/2016-12-01/583f0aaf55029.jpg"//评论图片

@property (nonatomic, copy) NSString * is_active;

- (void)sOrderCommentindexSuccess:(SOrderCommentindexSuccessBlock)success andFailure:(SOrderCommentindexFailureBlock)failure;
@end
