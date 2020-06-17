//
//  SUserCollectDelOneCollect.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserCollectDelOneCollectSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserCollectDelOneCollectFailureBlock) (NSError * error);

@interface SUserCollectDelOneCollect : NSObject
@property (nonatomic, copy) NSString * id_val;//对应id
@property (nonatomic, copy) NSString * type;//收藏品类型 1商品 2商家 3书院

- (void)sUserCollectDelOneCollectSuccess:(SUserCollectDelOneCollectSuccessBlock)success andFailure:(SUserCollectDelOneCollectFailureBlock)failure;
@end
