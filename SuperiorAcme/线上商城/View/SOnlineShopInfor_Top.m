//
//  SOnlineShopInfor_Top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShopInfor_Top.h"

@implementation SOnlineShopInfor_Top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOnlineShopInfor_Top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _topContent.layer.masksToBounds = YES;
        _topContent.layer.cornerRadius = 7.5;
        _topShopBtn.layer.masksToBounds = YES;
        _topShopBtn.layer.cornerRadius = 3;
        _topSearchView.layer.masksToBounds = YES;
        _topSearchView.layer.cornerRadius = 3;
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.layer.cornerRadius = 3;
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)type:(NSString *)choice {
    if ([choice isEqualToString:@"1"]) {
        [_oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitle:@"活动商品" forState:UIControlStateNormal];
    } else if ([choice isEqualToString:@"2"]) {
        [_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitle:@"活动商品" forState:UIControlStateNormal];
    } else if ([choice isEqualToString:@"3"]) {
        [_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_threeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitle:@"活动商品" forState:UIControlStateNormal];
    } else if ([choice isEqualToString:@"4"]) {
        [_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fourBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_fiveBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitle:@"活动商品" forState:UIControlStateNormal];
    } else if ([choice isEqualToString:@"5"]) {
        [_oneBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_twoBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_threeBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fourBtn setTitleColor:WordColor forState:UIControlStateNormal];
        [_fiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_fiveBtn setTitle:@"活动商品" forState:UIControlStateNormal];
    }
}
@end
