//
//  SRecommendingAdvertImg.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRecommendingAdvertImgSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRecommendingAdvertImgFailureBlock) (NSError * error);

@interface SRecommendingAdvertImg : NSObject
@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * picture;//": "http:\/\/img.wujiemall.com\/Uploads\/Ads\/2018-02-03\/5a7529179448b.png",
@property (nonatomic, copy) NSString * desc;//": "联盟商家-首页1",
@property (nonatomic, copy) NSString * width;//": "1242",
@property (nonatomic, copy) NSString * height;//": "400"

- (void)sRecommendingAdvertImgSuccess:(SRecommendingAdvertImgSuccessBlock)success andFailure:(SRecommendingAdvertImgFailureBlock)failure;
@end
