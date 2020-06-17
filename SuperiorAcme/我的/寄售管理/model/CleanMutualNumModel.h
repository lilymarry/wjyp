//
//  CleanMutualNumModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CleanMutualNumModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^CleanMutualNumModelFailureBlock) (NSError * error);
@interface CleanMutualNumModel : NSObject

@property (nonatomic, strong) CleanMutualNumModel * data;
@property (nonatomic, copy) NSString * can_sale_num;//可寄售数量
@property (nonatomic, copy) NSString * saling_num;//已寄售件数
@property (nonatomic, copy) NSString * ready_num;//已完成件数
@property (nonatomic, copy) NSString * income;//我的寄售收益
@property (nonatomic, copy) NSString * level;

- (void)CleanMutualNumModelSuccess:(CleanMutualNumModelSuccessBlock)success andFailure:(CleanMutualNumModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
