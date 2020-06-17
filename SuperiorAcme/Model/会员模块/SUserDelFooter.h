//
//  SUserDelFooter.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserDelFooterSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserDelFooterFailureBlock) (NSError * error);

@interface SUserDelFooter : NSObject
@property (nonatomic, copy) NSString * footer_ids;//把要删除的足迹id用逗号隔开

- (void)sUserDelFooterSuccess:(SUserDelFooterSuccessBlock)success andFailure:(SUserDelFooterFailureBlock)failure;
@end
