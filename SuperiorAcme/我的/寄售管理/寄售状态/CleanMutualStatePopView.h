//
//  CleanMutualStatePopView.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CleanMutualStatePopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (nonatomic, assign) BOOL shouldShowed;
+ (instancetype)initailzerWFOperationView;
- (void)showAtView:(UIView *)containerView rect:(CGRect)targetRect;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
