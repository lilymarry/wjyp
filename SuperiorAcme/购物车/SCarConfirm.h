//
//  SCarConfirm.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SCarConfirm_BackBlock) ();

@interface SCarConfirm : UIViewController
@property (nonatomic, copy) NSString * model_car_id;
@property (nonatomic, copy) NSString * model_car_img;
@property (nonatomic, copy) NSString * model_car_name;
@property (nonatomic, copy) NSString * model_pre_money;
@property (nonatomic, copy) NSString * model_all_price;
@property (nonatomic, copy) NSString * model_true_pre_money;

@property (nonatomic, assign) BOOL infor_isno;//汽车购详情YES
@property (nonatomic, copy) NSString * order_id;

@property (nonatomic, copy) SCarConfirm_BackBlock SCarConfirm_Back;
@end
