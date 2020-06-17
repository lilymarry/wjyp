//
//  SGoodsExplainCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/15.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsExplainCell.h"

@implementation SGoodsExplainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    /*
     *设置分割线的图片
     */
    self.separatorLine.image = [self drawLineOfDashByImageView:self.separatorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 *添加绘制分割线的方法
 */
- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
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
    
    CGContextAddLineToPoint(line, ScreenW + 100, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
