//
//  ExchangeListModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MoneyExchangeListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^MoneyExchangeModelSuccessBlock) (NSString * code, NSString * message);
typedef void(^MoneyExchangeListModelFailureBlock) (NSError * error);
@interface MoneyExchangeListModel : NSObject


@property(copy ,nonatomic)NSString * pay_type;
@property(copy ,nonatomic)NSString * coid ;

@property (nonatomic, strong) MoneyExchangeListModel * data ;
@property(copy ,nonatomic)NSString *coin;
@property (nonatomic, strong) NSArray * list ;
@property(copy ,nonatomic)NSString *coId ;

@property(copy ,nonatomic)NSString * coinsNumber;
@property(copy ,nonatomic)NSString * giftNumber ;
@property(copy ,nonatomic)NSString * isGift;
@property(copy ,nonatomic)NSString * price ;
@property(copy ,nonatomic)NSString * prizeImg;
;
- (void)MoneyExchangeListModelSuccess:(MoneyExchangeListModelSuccessBlock)success andFailure:(MoneyExchangeListModelFailureBlock)failure;

- (void)MoneyExchangeModelSuccess:(MoneyExchangeModelSuccessBlock)success andFailure:(MoneyExchangeListModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
