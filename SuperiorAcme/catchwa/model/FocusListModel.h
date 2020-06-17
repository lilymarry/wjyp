//
//  FocusListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FocusListModelSuccessBlock) (NSString * code, NSString * message, id data);

typedef void(^AddFocusModelSuccessBlock) (NSString * code, NSString * message);
typedef void(^FocusListModelFailureBlock) (NSError * error);

@interface FocusListModel : NSObject
@property (nonatomic, strong) NSArray * data;

@property (nonatomic, copy) NSString *cid ;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *name ;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *room_pic;
@property (nonatomic, copy) NSString *roomstatus;
@property (nonatomic, copy) NSString *status ;
@property (nonatomic, copy) NSString *user_id;




- (void)FocusListModelSuccess:(FocusListModelSuccessBlock)success andFailure:(FocusListModelFailureBlock)failure;

- (void)AddFocusModelSuccess:(AddFocusModelSuccessBlock)success andFailure:(FocusListModelFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
