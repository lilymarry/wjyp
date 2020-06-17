//
//  SEvaCar_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaCar_footer.h"
#import "HRelease_imageView.h"


@interface SEvaCar_footer () <UITextViewDelegate>
{
    NSMutableArray * imageArr;
    HRelease_imageView * rele_imageView;
}
@end

@implementation SEvaCar_footer

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _evaTV.delegate = self;
    
    rele_imageView = [[HRelease_imageView alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 100)];
    [_downView addSubview:rele_imageView];
    imageArr = [[NSMutableArray alloc] initWithObjects:@"照片默认", nil];
    //选择图片
    rele_imageView.HRelease_imageViewChoice = ^(UIButton * btn) {
        [self choiceImageView];
    };
    //观看图片
    rele_imageView.HRelease_imageViewLook = ^(NSInteger num) {
        // 图片游览器
        NSMutableArray * thisPic = [[NSMutableArray alloc] init];
        for (int i = 0; i < imageArr.count; i++) {
            if (i > 0) {
                [thisPic addObject:imageArr[i]];
            }
        }
        [self look:thisPic num:num - 1];
    };
    //删除图片
    rele_imageView.HRelease_imageViewClose = ^(NSInteger num) {
        if (self.SEvaCar_footer_Close) {
            self.SEvaCar_footer_Close(num);
        }
    };
}
- (void)closeShow:(NSInteger)num {
    [imageArr removeObjectAtIndex:num];
    [rele_imageView setChoiceImage:imageArr];
}
#pragma mark - 多图
- (void)choiceImageView {
    if (self.SEvaCar_footer_Choice) {
        self.SEvaCar_footer_Choice(imageArr);
    }
}
- (void)choiceShow:(NSMutableArray *)arr {
    [rele_imageView setChoiceImage:arr];
}
- (void)look:(NSMutableArray *)thisPhoto num:(NSInteger )num {
    if (self.SEvaCar_footer_Look) {
        self.SEvaCar_footer_Look(thisPhoto,num);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"写下您的评价吧~"]) {
        textView.text = @"";
        textView.textColor = WordColor;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"写下您的评价吧~";
        textView.textColor = WordColor_sub_sub;
    }
    return YES;
}
@end
