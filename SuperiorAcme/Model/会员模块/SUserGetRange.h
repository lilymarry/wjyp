//
//  SUserGetRange.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserGetRangeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserGetRangeFailureBlock) (NSError * error);

@interface SUserGetRange : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * cate_id;//"分类ID",
@property (nonatomic, copy) NSString * short_name;//"分类简称"
@property (nonatomic, assign) BOOL isno;

- (void)sUserGetRangeSuccess:(SUserGetRangeSuccessBlock)success andFailure:(SUserGetRangeFailureBlock)failure;
@end
