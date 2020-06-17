//
//  PeopleInRoomModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^PeopleInRoomModelSuccessBlock) (NSString * code, NSString * message, id data);

typedef void(^PeopleInRoomModelFailureBlock) (NSError * error);
@interface PeopleInRoomModel : NSObject
@property(copy ,nonatomic)NSString *   cid ;

@property (nonatomic, strong) PeopleInRoomModel * data ;

@property(strong ,nonatomic)NSArray *RoomPeople ;
@property(copy ,nonatomic)NSString *create_time;
@property(copy ,nonatomic)NSString *nickname ;
@property(copy ,nonatomic)NSString *head_pic;
- (void)PeopleInRoomModelSuccess:(PeopleInRoomModelSuccessBlock)success andFailure:(PeopleInRoomModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
