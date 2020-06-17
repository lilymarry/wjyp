//
//  SCartAddCollect.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCartAddCollectSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCartAddCollectFailureBlock) (NSError * error);

@interface SCartAddCollect : NSObject
@property (nonatomic, copy) NSString * cart_id_json;//    购物车ID json [{"cart_id":"购物车ID"}]

- (void)sCartAddCollectSuccess:(SCartAddCollectSuccessBlock)success andFailure:(SCartAddCollectFailureBlock)failure;
@end
