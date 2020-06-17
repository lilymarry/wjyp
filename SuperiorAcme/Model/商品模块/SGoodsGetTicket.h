//
//  SGoodsGetTicket.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsGetTicketSuccessBlock) (NSString * code, NSString * message);
typedef void(^SGoodsGetTicketFailureBlock) (NSError * error);

@interface SGoodsGetTicket : NSObject
@property (nonatomic, copy) NSString * ticket_id;//    优惠券ID

- (void)sGoodsGetTicketSuccess:(SGoodsGetTicketSuccessBlock)success andFailure:(SGoodsGetTicketFailureBlock)failure;
@end
