//
//  SAuctionRemindMe.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionRemindMeSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAuctionRemindMeFailureBlock) (NSError * error);

@interface SAuctionRemindMe : NSObject
@property (nonatomic, copy) NSString * auction_id;//拍卖活动id

- (void)sAuctionRemindMeSuccess:(SAuctionRemindMeSuccessBlock)success andFailure:(SAuctionRemindMeFailureBlock)failure;
@end
