//
//  SCarOrderAddComment.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderAddCommentSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCarOrderAddCommentFailureBlock) (NSError * error);

@interface SCarOrderAddComment : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    未提供
@property (nonatomic, copy) NSString * exterior;//    外观内饰评分    否    文本    未提供
@property (nonatomic, copy) NSString * space;//    空间舒适评分    否    文本    未提供
@property (nonatomic, copy) NSString * controllability;//    操控性    否    文本    未提供
@property (nonatomic, copy) NSString * consumption;//    油耗动力评分    否    文本    未提供
@property (nonatomic, copy) NSString * label_str;//    评分标签id 开始和结束有逗号    否    文本    未提供
@property (nonatomic, strong) NSDictionary * pictures;//    评论图片    否    文本    未提供
@property (nonatomic, copy) NSString * content;//    评价内容

- (void)sCarOrderAddCommentSuccess:(SCarOrderAddCommentSuccessBlock)success andFailure:(SCarOrderAddCommentFailureBlock)failure;
@end
