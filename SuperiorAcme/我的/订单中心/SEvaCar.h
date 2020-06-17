//
//  SEvaCar.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SEvaCar_BackBlock) ();

@interface SEvaCar : UIViewController
@property (nonatomic, copy) NSString * type;//汽车购、房产购
@property (nonatomic, copy) NSString * order_id;

@property (nonatomic, copy) SEvaCar_BackBlock SEvaCar_Back;
@end
