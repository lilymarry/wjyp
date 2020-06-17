//
//  SRecommendingBusinessType.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRecommendingBusinessTypeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRecommendingBusinessTypeFailureBlock) (NSError * error);


@interface SRecommendingBusinessType : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString *  rec_type_id;//": "1",       // 类型id
@property (nonatomic, copy) NSString * type;//": "电器/家电"      // 类型名

- (void)sRecommendingBusinessTypeSuccess:(SRecommendingBusinessTypeSuccessBlock)success andFailure:(SRecommendingBusinessTypeFailureBlock)failure;
@end
