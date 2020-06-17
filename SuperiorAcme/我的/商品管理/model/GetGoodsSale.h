//
//  GetGoodsSale.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetGoodsSaleSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^GetGoodsSaleFailureBlock) (NSError * error);
@interface GetGoodsSale : NSObject
@property (nonatomic, copy) NSString * goods_id;

@property (nonatomic, copy) NSString * sta_mid;


- (void)GetGoodsSaleSuccess:(GetGoodsSaleSuccessBlock)success andFailure:(GetGoodsSaleFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
