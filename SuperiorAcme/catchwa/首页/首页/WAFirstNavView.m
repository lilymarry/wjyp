//
//  WAFirstNavView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAFirstNavView.h"
@interface WAFirstNavView ()
@property (weak, nonatomic) IBOutlet UIView *view_buts;

@end

@implementation WAFirstNavView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAFirstNavView" owner:self options:nil];
        [self addSubview:_thisView];
        _view_buts.layer.masksToBounds = YES;
        _view_buts.layer.cornerRadius = 15;
        _view_buts.layer.borderWidth = 0.5;
         _view_buts.layer.borderColor =[UIColor colorWithRed:224/255.0 green:58/255.0 blue:133/255.0 alpha:1].CGColor;
        
        _view_scroll.layer.masksToBounds = YES;
        _view_scroll.layer.cornerRadius = 15;
        _view_scroll.layer.borderWidth = 0.5;
        _view_scroll.layer.borderColor = [UIColor colorWithRed:224/255.0 green:58/255.0 blue:133/255.0 alpha:1].CGColor;
        
  
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
