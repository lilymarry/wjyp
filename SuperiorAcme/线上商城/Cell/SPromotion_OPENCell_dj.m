//
//  SPromotion_OPENCell_dj.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPromotion_OPENCell_dj.h"

@implementation SPromotion_OPENCell_dj

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _redR.layer.masksToBounds = YES;
    _redR.layer.cornerRadius = 3;
    _lineImage.image = [self drawLineOfDashByImageView:_lineImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, ScreenW * 2, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {4,4};
    
    CGContextSetStrokeColorWithColor(line, MyLine.CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 300, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
@end
