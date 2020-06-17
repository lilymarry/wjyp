//
//  SHouseOrderAddComment.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderAddCommentSuccessBlock) (NSString * code, NSString * message);
typedef void(^SHouseOrderAddCommentFailureBlock) (NSError * error);

@interface SHouseOrderAddComment : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    未提供
@property (nonatomic, copy) NSString * price;//    价格评分    否    文本    未提供
@property (nonatomic, copy) NSString * lot;//    地段评分    否    文本    未提供
@property (nonatomic, copy) NSString * supporting;//    配套评分    否    文本    未提供
@property (nonatomic, copy) NSString * traffic;//    交通评分    否    文本    未提供
@property (nonatomic, copy) NSString * environment;//    环境评分    否    文本    未提供
@property (nonatomic, copy) NSString * label_str;//    评分标签id 开始和结束有逗号 逗号分隔    否    文本    未提供
@property (nonatomic, strong) NSDictionary * pictures;//    评论图片    否    文本    未提供
@property (nonatomic, copy) NSString * content;//    评价内容

- (void)HouseOrderAddCommentSuccess:(SHouseOrderAddCommentSuccessBlock)success andFailure:(SHouseOrderAddCommentFailureBlock)failure;
@end
