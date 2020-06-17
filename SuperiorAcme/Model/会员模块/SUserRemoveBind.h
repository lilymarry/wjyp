//
//  SUserRemoveBind.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserRemoveBindSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserRemoveBindFailureBlock) (NSError * error);

@interface SUserRemoveBind : NSObject
@property (nonatomic, copy) NSString * type;//type '1'=>'微信','2'=>'微博','3'=>'QQ'

- (void)sUserRemoveBindSuccess:(SUserRemoveBindSuccessBlock)success andFailure:(SUserRemoveBindFailureBlock)failure;
@end
