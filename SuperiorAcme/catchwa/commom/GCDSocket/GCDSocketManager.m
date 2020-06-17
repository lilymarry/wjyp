//
//  GCDSocketManager.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/29.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "GCDSocketManager.h"

@interface GCDSocketManager()<GCDAsyncSocketDelegate>

@property (nonatomic,copy)BLOCK block;
@property (nonatomic,copy)connectResultBLOCK resultBlock;

@property (nonatomic, assign) BOOL connected;

@end

@implementation GCDSocketManager
//全局访问点
+ (instancetype)sharedSocketManager {
    static GCDSocketManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//可以在这里做一些初始化操作
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark 请求连接
//连接
- (void)connectToServer:(NSString *)ToHost port:(NSString * )port complete:(connectResultBLOCK)block {
     
    if (!self.connected)
    {
        self.socket  = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSLog(@"开始连接%@",self.socket);
        
        NSError *error = nil;
        self.connected = [self.socket connectToHost:ToHost onPort:[port integerValue] viaInterface:nil withTimeout:15 error:&error];
        self.resultBlock = block;
        
        if(self.connected)
        {
            NSLog(@"客户端尝试连接");
        }
        else
        {
            self.connected = NO;
            NSLog(@"客户端未创建连接");
        }
    }
    else
    {
        NSLog(@"与服务器连接已建立");
    }
    
}

#pragma mark 连接成功
//连接成功的回调
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    self.resultBlock(@"1");
    
    NSLog(@"socket连接成功");
    
    
}
- (void)sendMessage:(NSData *)data complete:(BLOCK)block  {
    
    self.block = block;
    
    [self.socket writeData:data withTimeout:-1 tag:1];
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:200];
}
//连接成功向服务器发送数据后,服务器会有响应
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    self.block(data);
    [self.socket readDataWithTimeout:-1 tag:200];
}
#pragma mark 连接失败
//连接失败的回调
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"Socket连接失败");
    self.resultBlock(@"0");
    [self cutOffSocket];
}
#pragma mark 断开连接
//切断连接
- (void)cutOffSocket {
    NSLog(@"socket断开连接");
    self.socket.delegate = nil;
    [self.socket disconnect];
    self.socket = nil;
    self.connected = NO;
}
@end
