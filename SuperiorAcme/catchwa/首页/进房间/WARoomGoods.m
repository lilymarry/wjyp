//
//  WARoomGoods.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WARoomGoods.h"

@interface WARoomGoods ()
@property (weak, nonatomic) IBOutlet UIButton *OKBtn;
@end

@implementation WARoomGoods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WARoomGoods" owner:self options:nil];
        [self addSubview:_thisView];
        _OKBtn.layer.masksToBounds = YES;
        _OKBtn.layer.cornerRadius = 15;
        _OKBtn.layer.borderWidth = 5;
        _OKBtn.layer.borderColor =[UIColor clearColor].CGColor;
        
        
        
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
