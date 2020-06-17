//
//  SEasemobBind.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SEasemobBindSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SEasemobBindFailureBlock) (NSError * error);

@interface SEasemobBind : NSObject
@property (nonatomic, copy) NSString * merchant_id;//    商家id

@property (nonatomic, strong) SEasemobBind * data;
@property (nonatomic, copy) NSString * easemob_account_num;//": 2,          //商家客服账号数量
@property (nonatomic, copy) NSArray * easemob_account;
@property (nonatomic, copy) NSString * hx;//": "151237607243994",         //商家客服账号
@property (nonatomic, copy) NSString * nickname;//": "无界新人",            //商家客服昵称
@property (nonatomic, copy) NSString * head_pic;//": ""                         //商家客服账号头像
@property (nonatomic, copy) NSString * position;//": "职位",                   //商家客服职位
@property (nonatomic, copy) NSString * department_name;//": "",             //商家客服部门

- (void)sEasemobBindSuccess:(SEasemobBindSuccessBlock)success andFailure:(SEasemobBindFailureBlock)failure;
@end
