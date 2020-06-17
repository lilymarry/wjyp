//
//  MAMineActivtyView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "MAMineActivtyView.h"

@interface MAMineActivtyView ()

@end

@implementation MAMineActivtyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MAMineActivtyView" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (IBAction)surePress:(id)sender {
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
