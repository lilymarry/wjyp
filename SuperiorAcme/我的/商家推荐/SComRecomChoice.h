//
//  SComRecomChoice.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SComRecomChoiceSuccessBlock) (NSString * range_id, NSString * range_name);

@interface SComRecomChoice : UIViewController
@property (nonatomic, copy) NSString * submit_range_id;//是否选择类型了

@property (nonatomic, copy) SComRecomChoiceSuccessBlock SComRecomChoiceSuccess;
@end
