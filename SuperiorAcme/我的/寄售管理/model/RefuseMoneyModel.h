//
//  RefuseMoneyModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark 退款列表
typedef void(^RefuseMoneyListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^RefuseMoneyListModelFailureBlock) (NSError * error);

#pragma mark 退款
typedef void(^RefuseMoneyModelSuccessBlock) (NSString * code, NSString * message);
typedef void (^RefuseMoneyModelFailureBlock) (NSError * error);

@interface RefuseMoneyModel : NSObject
@property (nonatomic, strong) NSArray* data;
@property (nonatomic, copy) NSString *cause_id;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *clean_id;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *reason_desc;

- (void)RefuseMoneyListModelSuccess:(RefuseMoneyListModelSuccessBlock)success andFailure:(RefuseMoneyListModelFailureBlock)failure;

- (void)RefuseMoneyModelSuccess:(RefuseMoneyModelSuccessBlock)success andFailure:(RefuseMoneyModelFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
