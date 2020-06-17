//
//  CheckAPPHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTConfirmDeliveredView.h"

typedef void(^isNeedUpdateBlock)(BOOL update);

@interface CheckAPPHelper : NSObject

/** 定义一个单例类 **/
+ (CheckAPPHelper *)sharechechAPP;

/**
 * 检查版本更新
 * appId App的id
 * return 返回是否有更新.YES:有； NO:没有
 */
- (void)checkAppStoreVersionWithAppId:(NSString *)appId completion:(isNeedUpdateBlock)block;


@end
