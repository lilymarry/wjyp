//
//  SPayForMerchantController.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPayForMerchantController : UIViewController
@property (nonatomic, copy) NSString * url;//扫描二维码跳转时,传递的二维码url
@property (nonatomic, copy) NSString * merchant_id;//店铺id
@end
