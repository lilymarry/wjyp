//
//  SetWeekViewController.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^SetWeekFinishBlock)(NSArray *arr,NSString *type);
@interface SetWeekViewController : UIViewController
-(id)initWithBlock:(SetWeekFinishBlock)ablock;
@property(nonatomic,copy) SetWeekFinishBlock block;
@property(nonatomic,strong) NSString * type;
;
@property(nonatomic,strong) NSMutableArray * arr;
@property(nonatomic,strong) NSString * MerchantCate;
@end

NS_ASSUME_NONNULL_END
