//
//  SLineShop_inforSub.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLineShop_inforSub : UIViewController
@property (nonatomic, assign) BOOL type;//YES:线上 NO:线下
@property (nonatomic, copy) NSString * merchant_id;//商家id
@property (nonatomic, copy) NSString * merchant_name;//商家名称
@end
