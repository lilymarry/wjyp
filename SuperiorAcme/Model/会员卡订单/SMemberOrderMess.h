//
//  SMemberOrderMess.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderMessSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMemberOrderMessFailureBlock) (NSError * error);

@interface SMemberOrderMess : NSObject
@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * type;//": "1",             //类型（位置1->上方消息 2->下方消息）
@property (nonatomic, copy) NSString * content;//": "内容"    //内容

- (void)sMemberOrderMessSuccess:(SMemberOrderMessSuccessBlock)success andFailure:(SMemberOrderMessFailureBlock)failure;
@end
