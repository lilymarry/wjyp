//
//  SMemberOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMemberOrder : UIViewController
@property (nonatomic, assign) BOOL coming;//YES(线下)直接进来 NO支付进来

@property (nonatomic, copy) NSString * type;//会员卡 充值 线下商铺

@property (nonatomic, copy) NSString *pay_status;//线下商铺专用  1 支付完成后传进来

@end
