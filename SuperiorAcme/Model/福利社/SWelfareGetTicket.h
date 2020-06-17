//
//  SWelfareGetTicket.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SWelfareGetTicketSuccessBlock) (NSString * code, NSString * message);
typedef void(^SWelfareGetTicketFailureBlock) (NSError * error);

@interface SWelfareGetTicket : NSObject
@property (nonatomic, copy) NSString * ticket_id;//优惠券id

- (void)sWelfareGetTicketSuccess:(SWelfareGetTicketSuccessBlock)success andFailure:(SWelfareGetTicketFailureBlock)failure;
@end
