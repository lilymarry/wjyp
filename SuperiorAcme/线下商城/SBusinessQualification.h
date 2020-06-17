//
//  SBusinessQualification.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBShopDetailModel.h"
typedef void(^SBusinessQualification_choiceBlock) (NSString * report_type_id, NSString * report_type_name);

@interface SBusinessQualification : UIViewController
@property (nonatomic, assign) BOOL type;//NO:商家资质 YES:举报类型
@property (nonatomic, copy) NSString * merchant_id;//商家id
//线下 需要传数据过来展示
@property (nonatomic, strong) NSArray *other_license;

@property (nonatomic, copy) SBusinessQualification_choiceBlock SBusinessQualification_choice;
@end
