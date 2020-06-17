//
//  GCDSocketManager.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^BLOCK)(NSData* result);

typedef void(^connectResultBLOCK)(NSString* result);

@interface GCDSocketManager : NSObject<GCDAsyncSocketDelegate>

@property(nonatomic,strong) GCDAsyncSocket *socket;



//单例
+ (instancetype)sharedSocketManager;

//连接
- (void)connectToServer:(NSString *)ToHost port:(NSString * )port complete:(connectResultBLOCK)block;

//断开
- (void)cutOffSocket;

- (void)sendMessage:(NSData *)data complete:(BLOCK)block;
@end

NS_ASSUME_NONNULL_END
