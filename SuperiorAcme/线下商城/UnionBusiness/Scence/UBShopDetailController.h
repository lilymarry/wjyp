//
//  UBShopDetailController.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBShopDetailTableHelper.h"


@interface UBShopDetailController : UIViewController

@property (nonatomic, strong) UBShopDetailTableHelper *tableHelper;
@property (nonatomic, copy) NSString *merchant_id;

+ (instancetype)instanceWithMerchant_id:(NSString *)merchant_id;

@end
