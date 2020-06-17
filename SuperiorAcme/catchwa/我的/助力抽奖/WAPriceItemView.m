//
//  WAPriceItemView.m
//  TestChouJiang
//
//  Created by 天津沃天科技 on 2019/1/17.
//  Copyright © 2019年 yuancan. All rights reserved.
//

#import "WAPriceItemView.h"

@interface WAPriceItemView ()

@end

@implementation WAPriceItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAPriceItemView" owner:self options:nil];
        [self addSubview:_thisView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
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
