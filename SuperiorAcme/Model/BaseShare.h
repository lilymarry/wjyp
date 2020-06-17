//
//  BaseShare.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseShare : NSObject
/**
 从服务器获取分享url

 @param url 接口请求地址
 @param parameters 请求参数
 */
-(void)shareApi:(NSString *)url andParameters:(NSDictionary *)parameters andViewController:(UIViewController *)viewController andShareParameters:(NSDictionary *)dit;

@end
