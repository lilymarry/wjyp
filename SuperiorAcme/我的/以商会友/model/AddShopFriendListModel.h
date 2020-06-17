//
//  AddShopFriendListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddShopFriendListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^AddShopFriendListModelFailureBlock) (NSError * error);
@interface AddShopFriendListModel : NSObject
@property (nonatomic, copy) NSString * sta_mid;
- (void)AddShopFriendListModelSuccess:(AddShopFriendListModelSuccessBlock)success andFailure:(AddShopFriendListModelFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
