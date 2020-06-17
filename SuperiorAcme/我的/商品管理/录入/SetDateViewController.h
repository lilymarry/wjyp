//
//  SetDateViewController.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef  void (^SetDateFinishBlock)(NSDictionary *dic,NSString *type);
@interface SetDateViewController : UIViewController
-(id)initWithBlock:(SetDateFinishBlock)ablock;
@property(nonatomic,copy) SetDateFinishBlock block;
@property(nonatomic,strong) NSString * type;

@property(nonatomic,strong) NSString * startTime;
@property(nonatomic,strong) NSString * endTime;
@property(nonatomic,strong) NSString * price;
@property(nonatomic,strong) NSString * jieSuanPrice;
@property(nonatomic,strong) NSString * MerchantCate;
@end

NS_ASSUME_NONNULL_END
