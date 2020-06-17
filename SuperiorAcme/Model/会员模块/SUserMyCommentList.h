//
//  SUserMyCommentList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMyCommentListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserMyCommentListFailureBlock) (NSError * error);

@interface SUserMyCommentList : NSObject
//需要传入用户token
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * comment_id;// "评论ID",
@property (nonatomic, copy) NSString * goods_id;//"商品ID",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * user_id;//"用户ID",
@property (nonatomic, copy) NSString * nickname;//"昵称",
@property (nonatomic, copy) NSString * content;//"评论内容。",
@property (nonatomic, copy) NSString * all_star;//"评论星级",
@property (nonatomic, copy) NSString * product_id;//"货品id",
@property (nonatomic, copy) NSString * order_goods_id;//订单对应的商品,
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * user_head_pic;//"用户头像",
@property (nonatomic, copy) NSString * good_attr;//"商品属性",
@property (nonatomic, copy) NSString * goods_num;// 商品数量； ,
@property (nonatomic, copy) NSString * shop_price;//价格,
@property (nonatomic, copy) NSString * goods_img;// "商品图片"
@property (nonatomic, copy) NSString * order_type;//'订单类型'  //0普通订单 1团购订单 2无界预购 3竞拍汇 4积分夺宝 5无界商店 6汽车购 7房产购 8线下商城

@property (nonatomic, copy) NSString *reply_pictures;
@property (nonatomic, copy) NSString *reply;
@property (nonatomic, copy) NSString *reply_id;
@property (nonatomic, copy) NSArray  *reply_pictures_list;
@property (nonatomic, copy) NSString *review_path;
@property (nonatomic, copy) NSString *review_name;
@property (nonatomic, copy) NSString *review_status;
@property (nonatomic, copy) NSString *review_id;


@property (nonatomic, copy) NSArray * pictures;
@property (nonatomic, copy) NSString * path;//"评论图片"

- (void)sUserMyCommentListSuccess:(SUserMyCommentListSuccessBlock)success andFailure:(SUserMyCommentListFailureBlock)failure;
@end
