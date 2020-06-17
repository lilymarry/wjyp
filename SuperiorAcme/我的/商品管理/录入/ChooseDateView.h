//
//  ChooseDateView.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ChooseDateViewDelegate <NSObject>

-(void)chooseDateView:(NSString  *)data type:(NSString * )type;

-(void)removeDateView;
@end

@interface ChooseDateView : UIView
@property (strong, nonatomic)  UIDatePicker *datapicker;
@property (weak, nonatomic)  NSString *type;

@property (nonatomic,weak)id <ChooseDateViewDelegate>  delgate;
@end

NS_ASSUME_NONNULL_END
