//
//  SAfterSaleCause.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleCauseSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAfterSaleCauseFailureBlock) (NSError * error);

@interface SAfterSaleCause : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "1",
@property (nonatomic, copy) NSString * name;//": "买错商品"

- (void)sAfterSaleCauseSuccess:(SAfterSaleCauseSuccessBlock)success andFailure:(SAfterSaleCauseFailureBlock)failure;
@end
