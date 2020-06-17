//
//  CleanMutualStatePopView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/11.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CleanMutualStatePopView.h"
#define kXHALbumOperationViewSize CGSizeMake(236, 60)
@interface CleanMutualStatePopView ()
@property (nonatomic, assign) CGRect targetRect;
@end

@implementation CleanMutualStatePopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CleanMutualStatePopView" owner:self options:nil];
        [self addSubview:_thisView];
    
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (void)showAtView:(UITableView *)containerView rect:(CGRect)targetRect {
    self.targetRect = targetRect;
    if (self.shouldShowed) {
        return;
    }
    
    [containerView addSubview:self];
    
    CGFloat width = kXHALbumOperationViewSize.width;
    CGFloat height = kXHALbumOperationViewSize.height;
    
    self.frame = CGRectMake(targetRect.origin.x, targetRect.origin.y - 20, 0, height);
    self.shouldShowed = YES;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(targetRect.origin.x - width, targetRect.origin.y - 20, width, height);
    } completion:^(BOOL finished) {
     
    }];
}
+ (instancetype)initailzerWFOperationView {
    CleanMutualStatePopView *operationView = [[CleanMutualStatePopView alloc] initWithFrame:CGRectZero];
    return operationView;
}

- (void)dismiss {
    if (!self.shouldShowed) {
        return;
    }
    
    self.shouldShowed = NO;
    
    [UIView animateWithDuration:0.25f animations:^{
     [self removeFromSuperview];
      
    } completion:^(BOOL finished) {
    }];
}

@end
