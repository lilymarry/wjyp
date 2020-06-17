//
//  WAPriceTopView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAPriceTopView.h"

#import "WAPriceItemView.h"
@interface WAPriceTopView ()<CAAnimationDelegate>
{
    BOOL _isAnimation;
    int _circleAngle;
    NSArray *_prizeArray;
  
}
@property (weak, nonatomic) IBOutlet UIView*priceView;
@property (nonatomic, strong)UIImageView *backImaView;

@end

@implementation WAPriceTopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAPriceTopView" owner:self options:nil];
        [self addSubview:_thisView];
        [self initView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)initView{
    
    
    _prizeArray = @[@"10银两",@"土豪金ipad",@"50银两",@"精美平衡车",@"80银两",@"佳能单反相机",@"100银两",@"iphonex"];
    self.backImaView = [[UIImageView alloc]initWithFrame:CGRectMake(0,10, ScreenW-50, ScreenW-50 )];
    
    [self.backImaView setCenter:CGPointMake(ScreenW/2, ScreenW/2)];
    [self.backImaView setImage:[self rotateImageWithAngle:[UIImage imageNamed:@"抽奖转盘"] Angle:22.5 IsExpand:NO]];
    [self.priceView addSubview:self.backImaView];
    
    
    UIImageView *   _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,10, ScreenW-30,ScreenW-30)];
    _bgImageView.center = self.backImaView.center;
    _bgImageView.layer.masksToBounds = YES;
    _bgImageView.layer.cornerRadius = _bgImageView.frame.size.width/2;
    _bgImageView.layer.borderWidth =20;
    _bgImageView.layer.borderColor =[UIColor redColor].CGColor;
    _bgImageView.backgroundColor=[UIColor clearColor];
    [self.priceView addSubview:_bgImageView];
    
    
    UIImageView *   _bgImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, ScreenW-35,ScreenW-35)];
    _bgImageView1.center = self.backImaView.center;
    _bgImageView1.image = [UIImage imageNamed:@"圆彩灯"];
    _bgImageView1.backgroundColor=[UIColor clearColor];
    [self.priceView addSubview:_bgImageView1];
    
    
    //添加GO按钮图片
    UIButton *btnimage = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 85, 106)];
    [btnimage setBackgroundImage:[UIImage imageNamed:@"立即抽奖"] forState:UIControlStateNormal ];
    btnimage.backgroundColor=[UIColor clearColor];
    btnimage.center=self.backImaView.center;
    
    [self.priceView addSubview:btnimage];

    [btnimage addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    //添加文字
  
 
    for (int i = 0; i < 8; i ++) {
        
        WAPriceItemView *label = [[WAPriceItemView alloc]initWithFrame:CGRectMake(10, 0,M_PI * CGRectGetHeight(self.backImaView.frame)/8,CGRectGetHeight(self.backImaView.frame)*3/7)];
        label.layer.anchorPoint = CGPointMake(0.5, 1.05);
        label.center = CGPointMake(CGRectGetHeight(self.backImaView.frame)/2, CGRectGetHeight(self.backImaView.frame)/2);
        label.nameLab.text = [NSString stringWithFormat:@"%@", _prizeArray[i]];
        CGFloat angle = M_PI*2/8 * i;
        label.transform = CGAffineTransformMakeRotation(angle);
        [self.backImaView addSubview:label];
    }
    
}
#pragma mark 点击Go按钮
-(void)btnClick{
    
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    
    //控制概率[0,80)
    NSInteger lotteryPro = arc4random()%80;
    //设置转圈的圈数
    NSInteger circleNum = 6;
    
    if (lotteryPro < 10) {
        _circleAngle = 0;
    }else if (lotteryPro < 20){
        _circleAngle = 45;
    }else if (lotteryPro < 30){
        _circleAngle = 90;
    }else if (lotteryPro < 40){
        _circleAngle = 135;
    }else if (lotteryPro < 50){
        _circleAngle = 180;
    }else if (lotteryPro < 60){
        _circleAngle = 225;
    }else if (lotteryPro < 70){
        _circleAngle = 270;
    }else if (lotteryPro < 80){
        _circleAngle = 315;
    }
    
    CGFloat perAngle = M_PI/180.0;
    
    NSLog(@"turnAngle = %ld",(long)_circleAngle);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    int direction =- 1;  //时针方向 顺时针
    rotationAnimation.toValue = [NSNumber numberWithFloat:(_circleAngle * perAngle + 360 * perAngle * circleNum)*direction];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.backImaView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    _isAnimation = NO;
    int i;
    if (_circleAngle == 0) {
        i=0;
    }else if (_circleAngle == 45){
        i=1;
    }else if (_circleAngle == 90){
        i=2;
    }else if (_circleAngle == 135){
        i=3;
    }else if (_circleAngle == 180){
        i=4;
    }else if (_circleAngle == 225){
        i=5;
    }else if (_circleAngle == 270){
        i=6;
    }else if (_circleAngle == 315){
        i=7;
    }
    else
    {
        i=100;
        
    }
 
    if (i<100) {
    
           self.topBtnBlock(_prizeArray[i]);
    }
 
  
}
- (UIImage*)rotateImageWithAngle:(UIImage*)vImg Angle:(CGFloat)vAngle IsExpand:(BOOL)vIsExpand
{
    CGSize imgSize = CGSizeMake(vImg.size.width * vImg.scale, vImg.size.height * vImg.scale);
    
    CGSize outputSize = imgSize;
    if (vIsExpand) {
        CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
        //旋转
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(vAngle*M_PI/180.0));
        
        //NSLog(@"rotateImageWithAngle, size0:%f, size1:%f", imgSize.width, rect.size.width);
        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, vAngle*M_PI/180.0);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    
    [vImg drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
