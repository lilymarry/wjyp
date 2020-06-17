//
//  CircularProgressView.m
//  test
//
//  Created by wangsen on 2017/8/22.
//  Copyright © 2017年 wangsen. All rights reserved.
//

#import "CircularProgressView.h"
@interface CircularProgressView ()
@property (nonatomic, strong) CAShapeLayer * bottomLayer;
@property (nonatomic, strong) CAShapeLayer * topLayer;

@end
@implementation CircularProgressView

- (void)drawRect:(CGRect)rect {
    //中心点 半径
    CGPoint center = CGPointMake(rect.size.width/2.f + rect.size.width/2.f/2.f, rect.size.height/2.f + 10);
    CGFloat radius = floor(rect.size.width/2.f);
    CGFloat startAngle = (M_PI - M_PI_4);
    CGFloat endAngle = (M_PI * 2 + M_PI_4);
    //中间量
    CGFloat byAngle = (endAngle - startAngle) * _progress + startAngle;
    //底部
    UIBezierPath * bottomBazier = [UIBezierPath bezierPath];
    [bottomBazier addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.bottomLayer.path = bottomBazier.CGPath;
    //上部
    UIBezierPath * topBazier = [UIBezierPath bezierPath];
    [topBazier addArcWithCenter:center radius:radius startAngle:startAngle endAngle:byAngle clockwise:YES];
    self.topLayer.path = topBazier.CGPath;
    //执行动画
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //由延时 改代理方法执行
    pathAnimation.duration = 2.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    pathAnimation.autoreverses = NO;
    [self.topLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.lineCap = kCALineCapRound;
        _bottomLayer.lineWidth = 5.f;
        _bottomLayer.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor;
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomLayer.strokeEnd = 1;
        [self.layer addSublayer:_bottomLayer];
    }
    return _bottomLayer;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
        _topLayer.lineCap = kCALineCapRound;
        _topLayer.lineWidth = 5.f;
        _topLayer.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
        _topLayer.fillColor = [UIColor clearColor].CGColor;
        _topLayer.strokeEnd = 1;
        [self.layer addSublayer:_topLayer];
    }
    return _topLayer;
}


@end
