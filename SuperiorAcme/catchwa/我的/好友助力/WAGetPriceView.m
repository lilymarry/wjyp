//
//  WAGetPriceView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/17.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAGetPriceView.h"

@interface WAGetPriceView ()
@property (strong, nonatomic) IBOutlet UIButton *but;
@property (strong, nonatomic) IBOutlet UILabel *tittleLab;

@end

@implementation WAGetPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAGetPriceView" owner:self options:nil];
        [self addSubview:_thisView];
        _but.layer.masksToBounds = YES;
        _but.layer.cornerRadius = 15;
        _but.layer.borderWidth = 0.1;
        _but.layer.borderColor =[UIColor clearColor].CGColor;
        
        //字体加粗
        _nameLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        _tittleLab.font=[UIFont fontWithName:@"Helvetica-Bold" size:30];
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName:[UIColor redColor], NSStrokeColorAttributeName:[UIColor whiteColor],
                                     NSStrokeWidthAttributeName:@-3};
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:@"恭喜您" attributes:attributes];
        [ _tittleLab setAttributedText:attributeText];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (IBAction)butPress:(id)sender {
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
