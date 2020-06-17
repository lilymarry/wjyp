//
//  SWelfareFaceList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SWelfareFaceListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SWelfareFaceListFailureBlock) (NSError * error);

@interface SWelfareFaceList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SWelfareFaceList * data;

@property (nonatomic, copy) NSArray * announce;
@property (nonatomic, copy) NSString * announce_id;//"公告id",
@property (nonatomic, copy) NSString * title;//"公告标题"

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * bonus_id;//"红包id",
@property (nonatomic, copy) NSString * bonus_val;//红包金额,
@property (nonatomic, copy) NSString * merchant_id;//"商家id"
@property (nonatomic, copy) NSString * bonus_face;//商家logo

- (void)sWelfareFaceListSuccess:(SWelfareFaceListSuccessBlock)success andFailure:(SWelfareFaceListFailureBlock)failure;
@end
