//
//  SHouseConfirm.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SHouseConfirm_BackBlock) ();

@interface SHouseConfirm : UIViewController
@property (nonatomic, copy) NSString * model_house_id;
@property (nonatomic, copy) NSString * model_house_img;
@property (nonatomic, copy) NSString * model_house_name;
@property (nonatomic, copy) NSString * model_pre_money;
@property (nonatomic, copy) NSString * model_all_price;
@property (nonatomic, copy) NSString * model_true_pre_money;
@property (nonatomic, copy) NSString * model_developer;
@property (nonatomic, copy) NSString * model_one_price;

@property (nonatomic, assign) BOOL infor_isno;//房产购详情YES
@property (nonatomic, copy) NSString * order_id;

@property (nonatomic, copy) SHouseConfirm_BackBlock SHouseConfirm_Back;
@end
