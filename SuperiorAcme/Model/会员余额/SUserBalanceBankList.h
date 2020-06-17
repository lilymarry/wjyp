//
//  SUserBalanceBankList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceBankListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceBankListFailureBlock) (NSError * error);

@interface SUserBalanceBankList : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * bank_card_id;//": "银行卡id",
@property (nonatomic, copy) NSString * bank_type_id;//":银行卡类型ID""
@property (nonatomic, copy) NSString * bank_card_code;//": "63214523651450035",//银行卡号
@property (nonatomic, copy) NSString * bank_name;//": "工商银行",
@property (nonatomic, copy) NSString * bank_pic;//": "/Uploads/BankPic/1.png"//银行图标
@property (nonatomic, copy) NSString * open_bank;//": "开户行",
@property (nonatomic, copy) NSString * name;//": "户名"
@property (nonatomic, copy) NSString * phone;//":"手机号码"

- (void)sUserBalanceBankListSuccess:(SUserBalanceBankListSuccessBlock)success andFailure:(SUserBalanceBankListFailureBlock)failure;
@end
