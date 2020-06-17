//
//  SReportingMerchant.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SReportingMerchant : UIViewController
@property (nonatomic, copy) NSString * merchant_id;//商家id
@property (nonatomic, assign) BOOL isUnderline; //默认NO  线下专属
@end
