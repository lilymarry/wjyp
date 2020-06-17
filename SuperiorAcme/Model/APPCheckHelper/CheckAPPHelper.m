//
//  CheckAPPHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CheckAPPHelper.h"


@implementation CheckAPPHelper

+(CheckAPPHelper *)sharechechAPP{
    
    static CheckAPPHelper *single = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        single = [[CheckAPPHelper alloc] init];
        
    });
    
    return single;
}

- (void)checkAppStoreVersionWithAppId:(NSString *)appId completion:(isNeedUpdateBlock)block{
    // 1.拼接APPId,转化成URL
    NSString *checkUrlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",appId];
    [HttpManager postWithUrl:checkUrlString
               andParameters:@{}
                  andSuccess:^(id Json) {
                      NSLog(@"Json%@",Json);
                      if (SWNOTEmptyDictionary(Json)) {
                          NSArray *resultsAry = Json[@"results"];
                          NSDictionary *resultsDic = resultsAry.firstObject;
                          // 版本号
                          NSString *version = resultsDic[@"version"];
                          block([self compareVersion:version]);
                          
                      }else{
                           block(NO);
                      }
                  } andFail:^(NSError *error) {
                      NSLog(@"checkAppStoreVersionWithAppId = %@",[error localizedDescription]);
                  }];
    
    
}



- (BOOL)compareVersion:(NSString *)SenverVersion{
    
    // 获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    // 比较当前版本和新版本
    if ([appVersion compare:SenverVersion options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
    }else{
        return NO;
    }
}


@end
