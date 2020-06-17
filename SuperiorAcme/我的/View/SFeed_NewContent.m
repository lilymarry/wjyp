//
//  SFeed_NewContent.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SFeed_NewContent.h"

@interface SFeed_NewContent () <UITextViewDelegate>

@end

@implementation SFeed_NewContent

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SFeed_NewContent" owner:self options:nil];
        [self addSubview:_thisView];

        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _contentTV.delegate = self;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)showModel:(NSString *)real_name andUser_id:(NSString *)user_id {
    _real_name.text = real_name;
    _user_id.text = user_id;
}
- (void)submitBtnClick {
    if (self.SFeed_NewContent_Back) {
        self.SFeed_NewContent_Back(_contentTV.text);
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请描述您的问题"]) {
        textView.text = @"";
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请描述您的问题";
    }
    return YES;
}
@end
