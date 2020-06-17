//
//  STransferAccounts.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangeNowBalance) (NSString *balance);
@interface STransferAccounts : UIViewController
@property (nonatomic, copy) NSString * nowBalance;
@property (nonatomic, copy) NSString * type;// 1转账   2赠送
@property (nonatomic, copy) ChangeNowBalance changeNowBalance;
@property (nonatomic ,copy) NSString * shopid;
@end
