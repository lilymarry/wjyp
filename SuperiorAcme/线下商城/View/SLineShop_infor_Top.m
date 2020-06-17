//
//  SLineShop_infor_Top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_infor_Top.h"
#import "SOnlineShop_ClassView.h"

@implementation SLineShop_infor_Top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_infor_Top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _topTime.layer.masksToBounds = YES;
        _topTime.layer.cornerRadius = 12.5;
        
        _topPrice.layer.masksToBounds = YES;
        _topPrice.layer.cornerRadius = 12.5;
        
        _topShopBtn.layer.masksToBounds = YES;
        _topShopBtn.layer.cornerRadius = 3;
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"距您4.5km"];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 3)];
        _topDistance.attributedText = AttributedStr;
        
        _topSearchView.layer.masksToBounds = YES;
        _topSearchView.layer.cornerRadius = 3;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
@end
