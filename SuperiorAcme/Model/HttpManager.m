//
//  Created by 王森 on 15/3/30.
//  Copyright (c) 2015年 王森. All rights reserved.
//

#import "HttpManager.h"
#import "BaseAFNetworkingManager.h"
@interface HttpManager ()

@end

@implementation HttpManager

// 默认请求二进制
// 默认响应是JSON

+ (void)postWithUrl:(NSString *)url
      andParameters:(NSDictionary *)params
         andSuccess:(HttpSuccessBlock)success
            andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodPOST url:Base_url apiPath:url parameters:params progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)postSgiftWithUrl:(NSString *)url
                 baseurl:(NSString *)baseurl
      andParameters:(NSDictionary *)params
         andSuccess:(HttpSuccessBlock)success
            andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodPOST url:baseurl apiPath:url parameters:params progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        if (failure == nil) return ;
        failure(error);
    }];
}


+ (void)getWithUrl:(NSString *)url
     andParameters:(NSDictionary *)params
        andSuccess:(HttpSuccessBlock)success
           andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    NSLog(@"SSS %@",params);
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodGET url:Base_url apiPath:url parameters:params progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)postUploadSingleImageWithUrl:(NSString *)url
                        andImageName:(UIImage *)image
                          andKeyName:(NSString *)keyName
                       andParameters:(NSDictionary *)params
                          andSuccess:(HttpSuccessBlock)success
                             andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    if (keyName == nil) {
        keyName = @"";
    }
    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
    //   [manager.requestSerializer setValue:[SRegisterLogin shareInstance].method forHTTPHeaderField:@"METHOD"];
    }
  
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            NSString *suffix,*contentType;
            NSData * imageData;
            
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(image)) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(image);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(image, 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%@.%@",appendStringToImageName,suffix];
            
            [formData appendPartWithFileData:imageData name:keyName fileName:imageName mimeType:contentType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
+ (void)postShopUploadSingleImageWithUrl:(NSString *)url andImageName:(UIImage *)image andKeyName:(NSString *)keyName andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    if (keyName == nil) {
        keyName = @"";
    }
    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
       [manager.requestSerializer setValue:[SRegisterLogin shareInstance].method forHTTPHeaderField:@"METHOD"];
    }
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            NSString *suffix,*contentType;
            NSData * imageData;
            
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(image)) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(image);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(image, 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%@.%@",appendStringToImageName,suffix];
            
            [formData appendPartWithFileData:imageData name:keyName fileName:imageName mimeType:contentType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
    
    
}
+ (void)postUploadMultipleImagesWithUrl:(NSString *)url
                          andImageNames:(NSArray *)images
                             andKeyName:(NSString *)keyName
                          andParameters:(NSDictionary *)params
                             andSuccess:(HttpSuccessBlock)success
                                andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @{};
    }
    if (images == nil) {
        images = @[];
    }
    if (keyName == nil) {
        keyName = @"";
    }
    NSString *urlStr=url;
    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
    }
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < images.count; i++) {
            NSString *suffix,*contentType;
            NSData * imageData;
            
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(images[i])) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(images[i]);
                suffix = @"png";
                contentType = @"image/png";
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(images[i], 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";
            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.%@",(long)(i+10),appendStringToImageName,suffix];
            NSString * keyN;
            if (images.count == 1) {
                if ([urlStr isEqualToString:@"OsManager/addAppStageGoods"]) {
                     keyN = [NSString stringWithFormat:@"%@",keyName];
                }
                else
                {
                keyN = [NSString stringWithFormat:@"%@0",keyName];
                }
            } else {
                keyN = [NSString stringWithFormat:@"%@%ld",keyName,(long)i];
            }
            [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     if (success == nil) return ;
      id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)postUploadMultipleImagesWithUrl:(NSString *)url
                      andImagesAndNames:(NSDictionary *)imageAndNames
                          andParameters:(NSDictionary *)params
                             andSuccess:(HttpSuccessBlock)success
                                andFail:(HttpFailureBlock)failure {
    if (url == nil) {
        url = @"";
    }
    if (imageAndNames == nil) {
        imageAndNames = @{};
    }
    if (params == nil) {
        params = @{};
    }
    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
    NSArray * keys = [imageAndNames allKeys];
    NSArray * keyNames = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        
        return result == NSOrderedDescending;
    }];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
    }
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < keyNames.count; i++) {
            
            NSString * keyN = keyNames[i];
            NSLog(@"keyN:%@",keyN);
            
            NSString *suffix,*contentType;
            NSData * imageData;
            if (UIImageJPEGRepresentation(imageAndNames[keyN], 1.0)) {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(imageAndNames[keyN], 1.0);
                suffix = @"jpg";
                contentType = @"image/jpeg";

            }else {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(imageAndNames[keyN]);
                suffix = @"png";
                contentType = @"image/png";

            }
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
            NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@%zd.%@",(long)(i+10),appendStringToImageName,random(),suffix];
            NSLog(@"%@-----%@",keyN,imageAndNames[keyN]);
            [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}
//查看附件

+ (void)downloadWithUrl:(NSString *)strUrl
             andSuccess:(HttpSuccessBlock)success
             andFailure:(HttpFailureBlock)failure
{
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString * urlString = strUrl;
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString * cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString * path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL * fileURL = [NSURL fileURLWithPath:path];
        
        success(fileURL);
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        failure(error);
    }];
    
    [task resume];
    
}

//视频+图片
+ (void)postUploadImagesVideoWithUrl:(NSString *)url
                   andImageWithNames:(NSDictionary *)imagesAndNames
                            andVideo:(NSDictionary *)videoParams
                       andParameters:(NSDictionary *)params
                          andSuccess:(HttpSuccessBlock)success
                             andFail:(HttpFailureBlock)failure {
    
    if (url == nil) {
        url = @"";
    }
    if (imagesAndNames == nil) {
        imagesAndNames = @{};
    }
    if (params == nil) {
        params = @{};
    }
    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
    NSArray * keys = [imagesAndNames allKeys];
    NSArray * keyNames = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        
        return result == NSOrderedDescending;
    }];
    
    NSArray * videoKeys = [videoParams allKeys];
    NSArray * videoKeyNames = [videoKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        
        return result == NSOrderedDescending;
    }];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
    }
    
    __block NSInteger videoCount = 0;
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < keyNames.count + videoKeyNames.count; i++) {
            if (i < keyNames.count) {
                NSString * keyN = keyNames[i];
                NSString *suffix,*contentType;
                NSData * imageData;
                //判断图片是不是png格式的文件
                if (UIImagePNGRepresentation(imagesAndNames[keyN])) {
                    //返回为png图像。
                    imageData = UIImagePNGRepresentation(imagesAndNames[keyN]);
                    suffix = @"png";
                    contentType = @"image/png";
                }else {
                    //返回为JPEG图像。
                    imageData = UIImageJPEGRepresentation(imagesAndNames[keyN], 1.0);
                    suffix = @"jpg";
                    contentType = @"image/jpeg";
                }
                
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
                NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
                NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.%@",(long)(i+10),appendStringToImageName,suffix];
                NSLog(@"image:%@-----",keyN);
                [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
            } else {
                NSString * videoKey = videoKeyNames[videoCount];
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
                NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
                NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.amr",(long)(i+10),appendStringToImageName];
                
                [formData appendPartWithFileData:[NSData dataWithContentsOfURL:videoParams[videoKey]] name:videoKey fileName:imageName mimeType:@"audio/amr"];
                NSLog(@"video-====%@====%@",videoParams[videoKey],videoKey);
                videoCount++;
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success == nil) return ;
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure == nil) return ;
        failure(error);
    }];
}

+ (void)checkTheUpdate:(NSString *)appID responseResult:(void (^)(NSString *,NSString *, BOOL))checkResultBlock {
    NSString * appStoreUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",appID];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
    }
    
    [manager GET:appStoreUrl parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        NSArray * arr = dic[@"results"];
        NSString * appStore_version = nil;
        NSString * trackViewUrl = nil;
        NSString * descriptionInfo = nil;
        for (NSDictionary * dict in arr) {
            appStore_version = dict[@"version"];
            trackViewUrl = dict[@"trackViewUrl"];
            descriptionInfo = dict[@"description"];
        }
        NSString *version = [self infoPlistVersion];
        if ([version compare:appStore_version] == NSOrderedAscending) {
            checkResultBlock(appStore_version,descriptionInfo,YES);
        } else {
            checkResultBlock(appStore_version,@"暂无信息",NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        checkResultBlock(@"",[error localizedDescription],NO);
    }];
}
+ (NSString *)infoPlistVersion {
    NSString *version = nil;
    NSString *key = @"CFBundleShortVersionString"; //versiion版本
    //从Info.plist中取出版本号
    version = [NSBundle mainBundle].infoDictionary[key];
    return version;
}
+ (void)postjisonWithUrl:(NSString *)url andParameters:(NSString *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure
{
    if (url == nil) {
        url = @"";
    }
    if (params == nil) {
        params = @"";
    }
    BaseAFNetworkingManager *baseAFNetworkingManager = [BaseAFNetworkingManager defaultManager];
    [baseAFNetworkingManager sendRequestMethod:HTTPMethodPOST url:Base_url apiPath:url parameters:params progress:nil success:^(BOOL isSuccess, id  _Nullable responseObject) {
        if (success == nil) return ;
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        if (failure == nil) return ;
        failure(error);
    }];
    
    
}
//// 线下店铺 网页 上传图片
//+ (void)postWebUploadMultipleImagesWithUrl:(NSString *)url
//                          andImageNames:(NSArray *)images
//                             andKeyName:(NSString *)keyName
//                          andParameters:(NSDictionary *)params
//                             andSuccess:(HttpSuccessBlock)success
//                                andFail:(HttpFailureBlock)failure {
//    if (url == nil) {
//        url = @"";
//    }
//    if (params == nil) {
//        params = @{};
//    }
//    if (images == nil) {
//        images = @[];
//    }
//    if (keyName == nil) {
//        keyName = @"";
//    }
//    url = [NSString stringWithFormat:@"%@%@",Base_url,url];
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token) {
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        [manager.requestSerializer setValue:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token forHTTPHeaderField:@"token"];
//    }
//
//    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (NSInteger i = 0; i < images.count; i++) {
//            NSString *suffix,*contentType;
//            NSData * imageData;
//
//            //判断图片是不是png格式的文件
//            if (UIImagePNGRepresentation(images[i])) {
//                //返回为png图像。
//                imageData = UIImagePNGRepresentation(images[i]);
//                suffix = @"png";
//                contentType = @"image/png";
//            }else {
//                //返回为JPEG图像。
//                imageData = UIImageJPEGRepresentation(images[i], 1.0);
//                suffix = @"jpg";
//                contentType = @"image/jpeg";
//            }
//
//            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy/MM/dd-HH:mm:ss"];
//            NSString * appendStringToImageName = [formatter stringFromDate:[NSDate date]];
//            NSString * imageName = [NSString stringWithFormat:@"iPhone_%ld%@.%@",(long)(i+10),appendStringToImageName,suffix];
//            NSString * keyN;
//            if (images.count == 1) {
//                keyN = [NSString stringWithFormat:@"%@0",keyName];
//            } else {
//                keyN = [NSString stringWithFormat:@"%@%ld",keyName,(long)i];
//            }
//            [formData appendPartWithFileData:imageData name:keyN fileName:imageName mimeType:contentType];
//
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success == nil) return ;
//        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
//        success(json);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure == nil) return ;
//        failure(error);
//    }];
//}







@end
