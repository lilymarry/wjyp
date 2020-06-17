//
//  SUserReferList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserReferListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserReferListFailureBlock) (NSError * error);

@interface SUserReferList : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * refer_id;//"推荐商户id",
@property (nonatomic, copy) NSString * name;//"商户名称",
@property (nonatomic, copy) NSString * create_time;//"推荐时间",
@property (nonatomic, copy) NSString * status;//"状态",//0.待审核 1.已通过 2.未通过
@property (nonatomic, copy) NSString * product_pic;//"产品图片"

- (void)sUserReferListSuccess:(SUserReferListSuccessBlock)success andFailure:(SUserReferListFailureBlock)failure;
@end
