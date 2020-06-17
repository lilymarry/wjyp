//
//  MyWAWAListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MyWAWATitleModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^MyWAWATitleModelFailureBlock) (NSError * error);
@interface MyWAWATitleModel : NSObject
@property (nonatomic, strong) MyWAWATitleModel * data;
@property (nonatomic, strong) MyWAWATitleModel *count;
@property (nonatomic, copy) NSString *  already ;
@property (nonatomic, copy) NSString * deposit ;
@property (nonatomic, copy) NSString * exchange;
@property (nonatomic, copy) NSString *wait ;

@property (nonatomic, strong) MyWAWATitleModel *details;
@property (nonatomic, copy) NSString *chance_num;
@property (nonatomic, copy) NSString *head_pic;
@property (nonatomic, copy) NSString * id ;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *nums;

- (void)MyWAWATitleModelSuccess:(MyWAWATitleModelSuccessBlock)success andFailure:(MyWAWATitleModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
