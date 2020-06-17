//
//  SUserShareFriend.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserShareFriendSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserShareFriendFailureBlock) (NSError * error);

@interface SUserShareFriend : NSObject

@property (nonatomic, strong) SUserShareFriend * data;
@property (nonatomic, copy) NSString * share_id;//"分享id",
@property (nonatomic, copy) NSString * share_img;//": "分享图片",
@property (nonatomic, copy) NSString * share_title;//": "分享标题",
@property (nonatomic, copy) NSString * share_url;//": "分享链接"
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

- (void)sUserShareFriendSuccess:(SUserShareFriendSuccessBlock)success andFailure:(SUserShareFriendFailureBlock)failure;
@end
