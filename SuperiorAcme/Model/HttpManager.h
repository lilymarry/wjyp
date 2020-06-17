//
//  Created by 王森 on 15/3/30.
//  Copyright (c) 2015年 王森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"
typedef void(^HttpSuccessBlock) (id Json);
typedef void(^HttpFailureBlock) (NSError * error);
@interface HttpManager : NSObject
/**
 *  @author 15-06-04 22:06:02
 *
 *  post
 *
 *  @param url     网络地址
 *  @param params  上传参数
 *  @param success success
 *  @param failure failure
 */
+ (void)postWithUrl:(NSString *)url andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;

+ (void)postSgiftWithUrl:(NSString *)url
                 baseurl:(NSString *)baseurl
           andParameters:(NSDictionary *)params
              andSuccess:(HttpSuccessBlock)success
                 andFail:(HttpFailureBlock)failure;
/**
 *  @author 15-06-04 22:06:59
 *
 *  get
 *
 *  @param url     网络地址
 *  @param params  上传参数
 *  @param success success
 *  @param failure failure
 */
+ (void)getWithUrl:(NSString *)url andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;
/**
 *  @author 15-06-04 22:06:22
 *
 *  单张图片上传
 *
 *  @param url     网络地址
 *  @param image   图片image
 *  @param keyName 图片对应-键
 *  @param params  上传其它参数
 *  @param success success
 *  @param failure failure
 */
+ (void)postUploadSingleImageWithUrl:(NSString *)url andImageName:(UIImage *)image andKeyName:(NSString *)keyName andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;

+ (void)postShopUploadSingleImageWithUrl:(NSString *)url andImageName:(UIImage *)image andKeyName:(NSString *)keyName andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;


/**
 *  @author 15-06-04 22:06:28
 *
 *  多图片上传
 *
 *  @param url     网络地址
 *  @param images  图片image
 *  @param keyName 图片对应键 有规律的 对应名字拼接+0 +1 +2 +3 。。。
 *  @param params  上传其它参数
 *  @param success success
 *  @param failure failure
 */
+ (void)postUploadMultipleImagesWithUrl:(NSString *)url andImageNames:(NSArray *)images andKeyName:(NSString *)keyName andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;

/**
 *  @author 15-08-10 17:08:04
 *
 *  多图上传
 *
 *  @param url           网络地址
 *  @param imageAndNames @{@"imageName":image} 图片对应键
 *  @param params        其它参数
 *  @param success       success
 *  @param failure       failure
 */
+ (void)postUploadMultipleImagesWithUrl:(NSString *)url andImagesAndNames:(NSDictionary *)imageAndNames andParameters:(NSDictionary *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;

/**
 *  @author 15-06-04 22:06:28
 *
 *  查看附件
 *
 *  @param strUrl  附件url
 *  @param success success
 *  @param failure failure 
 */
+ (void)downloadWithUrl:(NSString *)strUrl andSuccess:(HttpSuccessBlock)success andFailure:(HttpFailureBlock)failure;

/**
 *  视频
 *  图片
 */
+ (void)postUploadImagesVideoWithUrl:(NSString *)url
                   andImageWithNames:(NSDictionary *)imagesAndNames
                            andVideo:(NSDictionary *)videoParams
                       andParameters:(NSDictionary *)params
                          andSuccess:(HttpSuccessBlock)success
                             andFail:(HttpFailureBlock)failure;

/**
 *  版本更新
 *
 */
+ (void)checkTheUpdate:(NSString *)appID responseResult:(void (^)(NSString *,NSString *, BOOL))checkResultBlock ;

/**
 获取当前设备版本号
 */
+ (NSString *)infoPlistVersion;

//json 格式
+ (void)postjisonWithUrl:(NSString *)url andParameters:(NSString *)params andSuccess:(HttpSuccessBlock)success andFail:(HttpFailureBlock)failure;
//// 线下店铺 网页 上传图片
//+ (void)postWebUploadMultipleImagesWithUrl:(NSString *)url
//                             andImageNames:(NSArray *)images
//                                andKeyName:(NSString *)keyName
//                             andParameters:(NSDictionary *)params
//                                andSuccess:(HttpSuccessBlock)success
//                                   andFail:(HttpFailureBlock)failure
@end
