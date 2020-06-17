//
//  WAMineFriendHelpSuccessView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineFriendHelpSuccessView.h"

@interface WAMineFriendHelpSuccessView ()

@end

@implementation WAMineFriendHelpSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAMineFriendHelpSuccessView" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (IBAction)surePress:(id)sender {
    
    [self removeView];
    
}
-(void)removeView
{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
