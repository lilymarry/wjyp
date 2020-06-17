//
//  ProfitDetailTopView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ProfitDetailTopView.h"

@interface ProfitDetailTopView ()

@end

@implementation ProfitDetailTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"ProfitDetailTopView" owner:self options:nil];
        [self addSubview:_thisView];
       
        _headView.layer.masksToBounds = YES;
        _headView.layer.cornerRadius = _headView.frame.size.width/2;
        _headView.layer.borderWidth = 0.5;
        _headView.layer.borderColor = [UIColor whiteColor].CGColor;
        
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
