//
//  HeWaWaModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/3.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^HeWaWaModelSuccessBlock) (NSString * code, NSString * message,id data);

typedef void(^HeWaWaModelFailureBlock) (NSError * error);

@interface HeWaWaModel : NSObject
@property(copy ,nonatomic)NSString *   goods_id ;
@property(copy ,nonatomic)NSString *   user_id ;

@property (nonatomic, strong) HeWaWaModel * data ;
@property(strong ,nonatomic)NSArray *listDetails ;

@property(copy ,nonatomic)NSString *create_time;
@property(copy ,nonatomic)NSString *name ;
@property(copy ,nonatomic)NSString *room_pic;

@property(strong ,nonatomic)NSArray *userDetails;

@property(copy ,nonatomic)NSString * cnum ;
@property(copy ,nonatomic)NSString *head_pic;
@property(copy ,nonatomic)NSString *nickname;


- (void)HeWaWaModelSuccess:(HeWaWaModelSuccessBlock)success andFailure:(HeWaWaModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
