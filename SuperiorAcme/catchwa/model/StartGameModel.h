//
//  StartGameModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^startGameModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^startGameModelFailureBlock) (NSError * error);

@interface StartGameModel : NSObject


@property (nonatomic, copy) NSString * id;


@property (nonatomic, strong) StartGameModel * data;

@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * silver;
@property (nonatomic, copy) NSString * logId;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * room_pic;
@property (nonatomic, strong) StartGameModel * nowUser;
@property (nonatomic, copy) NSString * head_pic;
@property (nonatomic, copy) NSString * nickname;


- (void)startGameModelSuccess:(startGameModelSuccessBlock)success andFailure:(startGameModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
