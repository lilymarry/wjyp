//
//  SOrderConfirm_down.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderConfirm_down.h"

@interface SOrderConfirm_down () <UITextViewDelegate>
@end

@implementation SOrderConfirm_down

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOrderConfirm_down" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        _leave_messageTV.delegate = self;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"选填：填写内容已和卖家协商确认"]) {
        _leave_messageTV.text = @"";
        _leave_messageTV.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        _leave_messageTV.text = @"选填：填写内容已和卖家协商确认";
        _leave_messageTV.textColor = WordColor_30;
    }
    return YES;
}
@end
