//
//  SortHeadPriceView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/10.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SortHeadPriceView.h"

@implementation SortHeadPriceView

-(void)awakeFromNib{
    [super awakeFromNib];

    for (UIView *subView in _fliterView.subviews) {
        if ([subView isMemberOfClass:[UIView class]]) {
            subView.layer.cornerRadius = subView.frame.size.height / 2.0;
            subView.clipsToBounds = YES;
        }
    }
    for (UIButton *btn in _sortView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = btn.frame.size.height / 2.0;
            btn.clipsToBounds = YES;
            
            [btn setTitleColor:UIColorHex(0x999999) forState:0];
            [btn setTitleColor:UIColorHex(0xFF5A5F) forState:1<<2];
        }
    }
}


#pragma mark - Action

- (IBAction)cancleAndSureBtnAction:(UIButton *)btn {
    switch (btn.tag) {
        case 100:
            {
                 [self missView];
            }
            break;
        case 101:  //确定
        {
            [self sureBtnAction];
        }
            break;
        default:   break;
    }
   
}

- (void)sureBtnAction{
    if (self.block) {
        NSString *sortStr = @"";
        NSString *filterStr = @"";
        if (_high_to_low_btn.selected) {
            sortStr = @"2";
        }else if (_low_to_high_btn.selected){
            sortStr = @"1";
        }
        
        if (SWNOTEmptyStr(_priceLowerTF.text)&&SWNOTEmptyStr(_priceHigherTF.text)) {
            filterStr = [NSString stringWithFormat:@"%@_%@",_priceLowerTF.text,_priceHigherTF.text];
        }
        
        self.block(sortStr,filterStr);
    }
    
    [self missView];
}

-(void)missView{
    [UIView animateWithDuration:.35 animations:^{
        self.superview.alpha = 0;
    } completion:^(BOOL finished) {
//        [self.superview removeFromSuperview];
    }];
}

- (void)showView{
    [UIView animateWithDuration:.35 animations:^{
        self.superview.alpha = 1;
    }];
}


- (IBAction)sortBtnAction:(UIButton *)btn {
    
    [btn.layer setBorderColor:UIColorHex(0xFF5A5F).CGColor];
    [btn.layer setBorderWidth:.50f];
    [btn setBackgroundColor:UIColorHex(0xFEDFDC)];
    btn.selected = YES;
    
    UIButton *tmpBtn = nil;
    if ([btn isEqual:_low_to_high_btn]) {
        tmpBtn = _high_to_low_btn;
    }else{
        tmpBtn = _low_to_high_btn;
    }
    
    [tmpBtn.layer setBorderColor:[UIColor clearColor].CGColor];
    [tmpBtn.layer setBorderWidth:0.0f];
    tmpBtn.selected = NO;
    [tmpBtn setBackgroundColor:UIColorHex(0xEEEEEE)];
    
    [self sureBtnAction];
}



+(instancetype)instaceWithXIB{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                         owner:nil
                                       options:nil].firstObject;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
