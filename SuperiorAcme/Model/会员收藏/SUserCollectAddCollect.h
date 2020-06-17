//
//  SUserCollectAddCollect.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserCollectAddCollectSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserCollectAddCollectFailureBlock) (NSError * error);

@interface SUserCollectAddCollect : NSObject
@property (nonatomic, copy) NSString * type;//收藏类型 1商品 2商家 3文章
@property (nonatomic, copy) NSString * id_val;//所选类型对应的id

- (void)sUserCollectAddCollectSuccess:(SUserCollectAddCollectSuccessBlock)success andFailure:(SUserCollectAddCollectFailureBlock)failure;
@end
