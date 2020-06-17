//
//  WAfirstItemListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^WAfirstItemListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^WAfirstItemListModelFailureBlock) (NSError * error);

@interface WAfirstItemListModel : NSObject
@property (nonatomic, copy) NSString * clumn;
@property (nonatomic, copy) NSString * per;
@property (nonatomic, copy) NSString * status;

@property (nonatomic, strong) WAfirstItemListModel * data;

@property (nonatomic, strong) NSArray * list;
@property (nonatomic, copy) NSString *id ;
@property (nonatomic, copy) NSString *pid;
//@property (nonatomic, copy) NSString *status ;
@property (nonatomic, copy) NSString *pic ;
@property (nonatomic, copy) NSString *des ;
@property (nonatomic, copy) NSString *name ;
@property (nonatomic, copy) NSString *create_time ;
@property (nonatomic, copy) NSString *update_time ;
@property (nonatomic, copy) NSString *mac ;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *exchange_price ;
@property (nonatomic, copy) NSString *recent ;
@property (nonatomic, copy) NSString *boutique ;
@property (nonatomic, copy) NSString *doll ;
@property (nonatomic, copy) NSString *beauty ;
@property (nonatomic, copy) NSString *practical ;
@property (nonatomic, copy) NSString *room_pic ;
@property (nonatomic, copy) NSString *status_ming  ;
- (void)WAfirstItemListModelSuccess:(WAfirstItemListModelSuccessBlock)success andFailure:(WAfirstItemListModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
