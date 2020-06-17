//
//  SOrderCommentGoods.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderCommentGoodsSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderCommentGoodsFailureBlock) (NSError * error);

@interface SOrderCommentGoods : NSObject
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品id    否    文本    1
@property (nonatomic, copy) NSString * content;//    评论内容
@property (nonatomic, strong) NSDictionary * pictures;//    商品图片 多个用','隔开
@property (nonatomic, copy) NSString * all_star;//    综合评论星级1-5    是    文本    5
@property (nonatomic, copy) NSString * order_id;//    订单id    是    文本    1
@property (nonatomic, copy) NSString * order_type;//    订单类型 1普通订单 2拼单购 3无界预购 4比价购 5积分抽奖

- (void)sOrderCommentGoodsSuccess:(SOrderCommentGoodsSuccessBlock)success andFailure:(SOrderCommentGoodsFailureBlock)failure;
@end
