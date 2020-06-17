//
//  ExchangeSuccessView.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ExchangeSuccessView.h"

@implementation ExchangeSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ExchangeSuccessView" owner:self options:nil].lastObject;
        self.frame = frame;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
