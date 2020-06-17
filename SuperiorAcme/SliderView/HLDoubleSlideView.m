//
//  HLDoubleSlideView.m
//  DriveUserProject
//
//  Created by sd on 16/3/16.
//  Copyright © 2016年 CJ. All rights reserved.
//

#import "HLDoubleSlideView.h"
#import "UIView+Add.h"

@interface HLDoubleSlideView ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,assign)CGFloat leftBtnOrgx;
@property(nonatomic,assign)CGFloat rightBtnOrgx;

@end

@implementation HLDoubleSlideView

-(id)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    
    
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.image = [UIImage imageNamed:@"水滴"];
    _leftImageView.frame = CGRectMake(0, 100, 40, 40);
    [self addSubview:_leftImageView];
    
    _leftLabel = [[UILabel alloc] initWithFrame:_leftImageView.bounds];
    _leftLabel.backgroundColor = [UIColor clearColor];
    _leftLabel.font = [UIFont systemFontOfSize:13];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.textColor = [UIColor whiteColor];
    [_leftImageView addSubview:_leftLabel];
    
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.image = [UIImage imageNamed:@"水滴"];
    _rightImageView.frame = CGRectMake(0, 100, 40, 40);
    [self addSubview:_rightImageView];
    
    _rightLabel = [[UILabel alloc] initWithFrame:_rightImageView.bounds];
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.font = [UIFont systemFontOfSize:13];
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.textColor = [UIColor whiteColor];
    [_rightImageView addSubview:_rightLabel];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 150/2 - 15, 30,30);
    _leftBtn.backgroundColor = [UIColor redColor];
    _leftBtn.layer.cornerRadius = 15;
    [self addSubview:_leftBtn];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    panGesture.delegate = self;
    [_leftBtn addGestureRecognizer:panGesture];
    
    _leftImageView.centerX = _leftBtn.centerX;
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.backgroundColor = [UIColor redColor];
    _rightBtn.frame = CGRectMake(240, 150/2 - 15, 30, 30);
    _rightBtn.layer.cornerRadius = 15;
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    panGesture.delegate = self;
    [_rightBtn addGestureRecognizer:panGesture];
    _rightImageView.centerX = _rightBtn.centerX;


    [self addSubview:_rightBtn];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"doubleView hitTest");
    return [super hitTest:point withEvent:event];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began");
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"move");
    [super touchesMoved:touches withEvent:event];
}


-(void)layoutSubviews
{
    
    CGFloat centenX = (_currentLeftValue - _minValue) * (self.bounds.size.width - 30)/(_maxValue - _minValue) + 15;
    _leftBtn.centerX = centenX;
    
    if (_currentLeftValue != 0) {
        CGFloat centenX = (_currentRightValue - _minValue) * (self.bounds.size.width - 30) / (_maxValue - _minValue) + 15;
        _rightBtn.centerX = centenX;


    }
    else
    {
        _rightBtn.centerX = self.bounds.size.width - 15;

    }
   
    
    _leftImageView.centerX = _leftBtn.centerX;
    _rightImageView.centerX = _rightBtn.centerX;
    if (_block) {
        _leftLabel.text = [NSString stringWithFormat:@"%.0f",_currentLeftValue];
        _rightLabel.text = [NSString stringWithFormat:@"%.0f",_currentRightValue];
        _block(_currentLeftValue,_currentRightValue);
    }
}

-(void)tapGestureAction:(UIPanGestureRecognizer*)panGesture
{
    UIView *vw = panGesture.view;
    
    CGPoint transPoint = [panGesture translationInView:self];
    NSLog(@"x:%lf,y:%lf",transPoint.x,transPoint.y);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if ([vw isEqual:_leftBtn])
            {
                _leftBtnOrgx = _leftBtn.orgX;
                NSLog(@"拖拽左边按钮");
                
            }
            else if([vw isEqual:_rightBtn])
            {
                _rightBtnOrgx = _rightBtn.orgX;
                NSLog(@"拖拽右边按钮");
            }

        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            if ([vw isEqual:_leftBtn])
            {
                
                CGFloat orginX = _leftBtn.orgX;
                _leftBtn.orgX = _leftBtnOrgx + transPoint.x;
                if (_leftBtn.orgX < 0) {
                    _leftBtn.orgX = 0;
                }
                else if(_leftBtn.orgX >= _rightBtn.orgX - 30)
                {
                    _leftBtn.orgX = orginX;
                }
                 _leftImageView.centerX = _leftBtn.centerX;
            }
            else if([vw isEqual:_rightBtn])
            {
                CGFloat orginX = _rightBtn.orgX;
                _rightBtn.orgX = _rightBtnOrgx + transPoint.x;
                if (_rightBtn.orgX >= self.bounds.size.width - 30) {
                    _rightBtn.orgX = self.bounds.size.width - 30;
                }
                else if(_rightBtn.orgX <= _leftBtn.orgX + 30)
                {
                    _rightBtn.orgX = orginX;
                }
                 _rightImageView.centerX = _rightBtn.centerX;
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }
    _currentLeftValue = _minValue + (_maxValue - _minValue) * ((_leftBtn.centerX - 15) / (self.bounds.size.width - 30));
    _currentRightValue = _minValue + (_maxValue - _minValue) * ((_rightBtn.centerX - 15) / (self.bounds.size.width - 30));
    if (_block) {
        _leftLabel.text = [NSString stringWithFormat:@"%.0f",_currentLeftValue];
        _rightLabel.text = [NSString stringWithFormat:@"%.0f",_currentRightValue];
        _block(_currentLeftValue,_currentRightValue);
    }
    
    
    NSLog(@"leftValue:%lf,rightValue:%lf",_currentLeftValue,_currentRightValue);
    
    [self setNeedsDisplay];
}

-(void)setCurrentLeftValue:(CGFloat)currentLeftValue
{
    _currentLeftValue = currentLeftValue;
    CGFloat centenX = (currentLeftValue - _minValue) * (self.bounds.size.width - 30)/(_maxValue - _minValue) + 15;
    _leftBtn.centerX = centenX;
    [self setNeedsDisplay];
}

-(void)setCurrentRightValue:(CGFloat)currentRightValue
{
    _currentRightValue = currentRightValue;
    CGFloat centenX = (_currentRightValue - _minValue) * (self.bounds.size.width - 30) / (_maxValue - _minValue) + 15;
    _rightBtn.centerX = centenX;
    [self setNeedsDisplay];

    
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 10);
    [[UIColor whiteColor] setStroke];
    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.frame.size.height/2);
    CGContextStrokePath(context);
    
    [[UIColor redColor] setStroke];
    CGContextMoveToPoint(context, _leftBtn.orgX + 10, self.frame.size.height/2);
    CGContextAddLineToPoint(context, _rightBtn.orgX,self.frame.size.height/2);
    CGContextStrokePath(context);
    
}

@end
