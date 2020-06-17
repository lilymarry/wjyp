//
//  MyGiftDetailModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/29.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^MyGiftDetailModelSuccessBlock) (NSString * code, NSString * message ,id data);
typedef void(^MyGiftDetailModelFailureBlock) (NSError * error);
@interface MyGiftDetailModel : NSObject
@property (copy,nonatomic) NSString * p;

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "4",//地址id
@property (nonatomic, copy) NSString * reason;//": "GYM",//收货人
@property (nonatomic, copy) NSString * create_time;//": "18600001234",//联系电话
@property (nonatomic, copy) NSString * money;//": "天津市南开区华苑鑫茂科技园",//地址
@property (nonatomic, copy) NSString * add_sub;//": "天津市",//市
@property (nonatomic, copy) NSString * img;//": "天津市",//市

- (void)MyGiftDetailModelSuccess:(MyGiftDetailModelSuccessBlock)success andFailure:(MyGiftDetailModelFailureBlock)failure;
@end
