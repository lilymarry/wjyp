//
//  CatchHistoryModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^UserCatchHistoryModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^UserCatchHistoryModelFailureBlock) (NSError * error);

@interface UserCatchHistoryModel : NSObject
@property (nonatomic, strong) NSArray *data ;
@property (nonatomic, copy) NSString *cid ;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *details ;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *head_pic;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong) UserCatchHistoryModel *roomBean ;
@property (nonatomic, copy) NSString *    beauty ;
@property (nonatomic, copy) NSString *   boutique ;
@property (nonatomic, copy) NSString *   countdown ;
//@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *   des ;
@property (nonatomic, copy) NSString *    doll;
@property (nonatomic, copy) NSString *exchange_price;
@property (nonatomic, copy) NSString * id ;
@property (nonatomic, copy) NSString *  mac ;
@property (nonatomic, copy) NSString *  name ;
@property (nonatomic, copy) NSString *  pic  ;
@property (nonatomic, copy) NSString *  pid ;
@property (nonatomic, copy) NSString *  practical ;
@property (nonatomic, copy) NSString *  price ;
@property (nonatomic, copy) NSString * recent;
@property (nonatomic, copy) NSString * room_pic;
@property (nonatomic, copy) NSString * status ;
@property (nonatomic, copy) NSString *status_ming;
@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *url ;
@property (nonatomic, copy) NSString *user_id;



- (void)UserCatchHistoryModelSuccess:(UserCatchHistoryModelSuccessBlock)success andFailure:(UserCatchHistoryModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
