//
//  SAfterSaleShowAfter.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleShowAfterSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAfterSaleShowAfterFailureBlock) (NSError * error);

@interface SAfterSaleShowAfter : NSObject
@property (nonatomic, copy) NSString * apply_id;//    售后id

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * type;//": "1",  //1是用户  2：是商家
@property (nonatomic, copy) NSString * content;//": "内容",  //内容
@property (nonatomic, copy) NSString * time;//": "2016/12/17 10:41:57",  //时间
@property (nonatomic, copy) NSString * title;//": "买家发起申请",  //标题
@property (nonatomic, copy) NSString * is_title;//":"0"//是否显示标题 1是0否
@property (nonatomic, copy) NSString * setting;//":"1" //1橘红色 2蓝色 只针对于type = 2 商家

- (void)sAfterSaleShowAfterSuccess:(SAfterSaleShowAfterSuccessBlock)success andFailure:(SAfterSaleShowAfterFailureBlock)failure;
@end
