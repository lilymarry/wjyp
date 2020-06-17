//
//  SUserCollectDelCollect.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserCollectDelCollectSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserCollectDelCollectFailureBlock) (NSError * error);

@interface SUserCollectDelCollect : NSObject
@property (nonatomic, copy) NSString * collect_ids;//收藏编号ID 多个用逗号隔开

- (void)sUserCollectDelCollectSuccess:(SUserCollectDelCollectSuccessBlock)success andFailure:(SUserCollectDelCollectFailureBlock)failure;
@end
