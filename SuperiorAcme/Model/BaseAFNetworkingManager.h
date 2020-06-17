//
//  BaseAFNetworkingManager.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//  基础网络请求类

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"


/**
 请求方式

 - HTTPMethodGET: 获取资源，不会改动资源
 - HTTPMethodPOST: 创建记录
 - HTTPMethodPUT: 更新全部属性
 - HTTPMethodPATCH: 改变资源状态或更新部分属性
 - HTTPMethodDELETE: 删除资源
 */
typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodPUT,
    HTTPMethodPATCH,
    HTTPMethodDELETE,
};

@interface BaseAFNetworkingManager : NSObject


/**
 单例方法

 @return 网络请求实例
 */
+ (instancetype)defaultManager;

/**
 网络请求

 @param requestMethod 请求方式
 @param url 服务器地址
 @param apiPath api方法地址
 @param parameters 参数
 @param progress 进度
 @param success 成功
 @param failure 失败
 @return return value description
 */
- (nullable NSURLSessionDataTask *)sendRequestMethod:(HTTPMethod)requestMethod url:(nonnull NSString *)url apiPath:(nonnull NSString *)apiPath parameters:(nullable id)parameters progress:(nullable void(^)(NSProgress *_Nullable progress))progress success:(nullable void(^)(BOOL isSuccess, id _Nullable responseObject))success failure:(nullable void(^)(NSError * _Nullable error))failure;

@end
