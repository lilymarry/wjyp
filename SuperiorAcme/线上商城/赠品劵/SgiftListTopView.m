//
//  SgiftListTopView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SgiftListTopView.h"

@interface SgiftListTopView ()

@end

@implementation SgiftListTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SgiftListTopView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _picImaView.layer.masksToBounds = YES;
        _picImaView.layer.cornerRadius = 5;
        _picImaView.layer.borderWidth = 0.5;
        _picImaView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
    
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
