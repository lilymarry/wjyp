//
//  CustomLabel.m

//
//  Created by 科技沃天 on 2018/4/16.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import "CustomLabel.h"


//自定义Label,实现设置label的内边距
@interface CustomLabel ()
@end
@implementation CustomLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}


-(void)LabelAddImageWithImageName:(NSString *)imageName{
    //获取文字的高度
    CGFloat textHeight = [self getSizeWithStr:[self GetFirstLetterFromString:self.text] Width:self.bounds.size.width Font:self.font.pointSize].height;
    
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    //天机图片
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    attchImage.image = [UIImage imageNamed:imageName];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0, -textHeight * 0.2, textHeight, textHeight);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    self.attributedText = attriStr;
}

#pragma mark - 固定宽度和字体大小，获取label的frame
- (CGSize) getSizeWithStr:(NSString *) str Width:(float)width Font:(float)fontSize
{
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize tempSize = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    return tempSize;
}
-(NSString *)GetFirstLetterFromString:(NSString *)text{
    NSString * firstLetterStr = [text substringWithRange:NSMakeRange(0, 1)];
    return firstLetterStr;
}
@end
