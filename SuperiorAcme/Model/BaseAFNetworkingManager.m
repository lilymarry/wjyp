//
//  BaseAFNetworkingManager.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "BaseAFNetworkingManager.h"

@interface BaseAFNetworkingManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation BaseAFNetworkingManager

static BaseAFNetworkingManager *baseAFNetworkingManage = nil;

/**
 单例

 @return 网络请求类的实例
 */
+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!baseAFNetworkingManage) {
            baseAFNetworkingManage = [[BaseAFNetworkingManager alloc] init];
        }
    });
    return baseAFNetworkingManage;
}

- (instancetype)init {
    if (self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        //设置超时时间
        self.sessionManager.requestSerializer.timeoutInterval = 60.0;
        //设置响应内容的类型
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    }
    return self;
}

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
- (nullable NSURLSessionDataTask *)sendRequestMethod:(HTTPMethod)requestMethod url:(nonnull NSString *)url apiPath:(nonnull NSString *)apiPath parameters:(nullable id)parameters progress:(nullable void(^)(NSProgress *_Nullable progress))progress success:(nullable void(^)(BOOL isSuccess, id _Nullable responseObject))success failure:(nullable void(^)(NSError * _Nullable error))failure {
    //检查本地token
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        
        NSLog(@"sssss %@",[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token);
        [self.sessionManager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
        /*
         *分销模块,添加新的header
         */
        [self.sessionManager.requestSerializer setValue:[SRegisterLogin shareInstance].method forHTTPHeaderField:@"METHOD"];
    } else {
        [self.sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    }
    //请求的地址
    NSString *requestPath = [url stringByAppendingPathComponent:apiPath];
    NSURLSessionDataTask *task = nil;
    switch (requestMethod) {
        case HTTPMethodGET: {
            task = [self.sessionManager GET:requestPath parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [self errorDispose:error result:^(BOOL result) {
                        if (result) failure(error);
                    }];
                }
            }];
        }
            break;
        case HTTPMethodPOST: {
            task = [self.sessionManager POST:requestPath parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    [self errorDispose:error result:^(BOOL result) {
                        if (result) failure(error);
                    }];
                }
            }];
        }
            break;
        case HTTPMethodPUT: {
            task = [self.sessionManager PUT:requestPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HTTPMethodDELETE: {
            task = [self.sessionManager DELETE:requestPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HTTPMethodPATCH: {
            task = [self.sessionManager PATCH:requestPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(YES, responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
    return task;
}

#pragma mark 报错信息
/**
 处理报错信息
 
 @param error AFN返回的错误信息
 @param task 任务
 @return description
 */
- (NSString *)failHandleWithErrorResponse:( NSError * _Nullable )error task:( NSURLSessionDataTask * _Nullable )task {
    __block NSString *message = nil;
    // 这里可以直接设定错误反馈，也可以利用AFN 的error信息直接解析展示
    NSData *afNetworking_errorMsg = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (!afNetworking_errorMsg) {
        message = @"网络连接失败";
    }
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger responseStatue = response.statusCode;
    if (responseStatue >= 500) {  // 网络错误
        message = @"服务器维护升级中,请耐心等待";
    } else if (responseStatue >= 400) {
        // 错误信息
        //  NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:afNetworking_errorMsg options:NSJSONReadingAllowFragments error:nil];
        //  message = responseObject[@"error"];
        message = @"网络连接失败";
    }
    return message;
}



- (void)errorDispose:(NSError * _Nonnull)error result:(nullable void(^)(BOOL result))resultBlock{
    if ([error code] == 3840) {
        //json格式错误，文字提醒后，放回上一层
//        UIViewController *currentVC = ((UINavigationController *)((UITabBarController *)[self getCurrentVC]).selectedViewController).viewControllers.lastObject;
       UIViewController * vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
        [MBProgressHUD hideHUDForView:vc.view animated:YES];
        if (vc.view) {
         [MBProgressHUD showError:@"数据请求有误,暂不能预览!" toView:vc.view];
        }
       [self performSelector:@selector(goBack) withObject:nil afterDelay:1.0];
    } else {
        if (resultBlock) resultBlock(YES);
    }
}


/**
 获取当前控制器

 @return 返回当前控制器
 */
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}


/**
 返回上一层
 */
- (void)goBack {
//    [((UITabBarController *)[self getCurrentVC]).selectedViewController popViewControllerAnimated:YES];
    UIViewController * vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
       [((UITabBarController *)[self getCurrentVC]).selectedViewController popViewControllerAnimated:YES];
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        [(UINavigationController *)vc popViewControllerAnimated:YES];
    }else{
        [vc.navigationController popViewControllerAnimated:YES];
    }
    return;
}

@end
