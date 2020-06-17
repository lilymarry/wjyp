//
//  SUserMyShare.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMyShareSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserMyShareFailureBlock) (NSError * error);

@interface SUserMyShare : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//"1",
@property (nonatomic, copy) NSString * user_id;//"用户id",
@property (nonatomic, copy) NSString * type;//"微信分享",//分享类型
@property (nonatomic, copy) NSString * content;//"分享测试",//分享内容
@property (nonatomic, copy) NSString * title;//"12", //分享标题
@property (nonatomic, copy) NSString * url;//"www.baidu.com"//分享链接
@property (nonatomic, copy) NSString * create_time;//"2017-09-01",//分享时间
@property (nonatomic, copy) NSString * pic;//"分享略缩图"

- (void)sUserMyShareSuccess:(SUserMyShareSuccessBlock)success andFailure:(SUserMyShareFailureBlock)failure;
@end
