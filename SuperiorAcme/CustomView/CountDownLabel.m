//
//  CountDownLabel.m
//  CustomUI
//
//  Created by 科技沃天 on 2018/5/15.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import "CountDownLabel.h"

#define DEFAULT_TEXT_BACKGROUND_COLOR [UIColor blackColor]
#define DEFAULT_TEXT_CORNER_RADIUS 3
#define DEFAULT_TEXT_COLOR [UIColor blackColor]
#define DEFAULT_DATE_COLOR [UIColor whiteColor]

@interface CountDownLabel ()

@property (nonatomic, assign) CGFloat NumWidth;
@property (nonatomic, assign) CGFloat NumHeight;

@property (nonatomic, assign) CGFloat startPositionX;
@property (nonatomic, assign) CGFloat startPositionY;
@property (nonatomic, assign) CGFloat OriginalPositionX;

@property (nonatomic, assign) CGFloat spaceWidth;

@property (nonatomic, copy) NSString * tempString;

@property (nonatomic, assign) BOOL isGot;

@property (nonatomic, assign) NSUInteger previousStringLength;

@end

@implementation CountDownLabel

-(void)setText:(NSString *)text{
    [super setText:text];
    
    if (self.previousStringLength != text.length) {
        self.isGot = NO;
        self.previousStringLength = text.length;
    }
}

-(void)GetTextPositionMessage{
    //获取空格字符的宽和高
    CGRect commenRectSpace = [self getHeightLineWithString:@" " withWidth:self.bounds.size.width withFont:self.font];
    self.spaceWidth = commenRectSpace.size.width;
    
    
    //获取数字0的宽和高
    CGRect commenRect0 = [self getHeightLineWithString:@"0" withWidth:self.bounds.size.width withFont:self.font];
    self.NumWidth = commenRect0.size.height + commenRectSpace.size.width;
    self.NumHeight = commenRect0.size.height;
    
    
    //获取绘制文字的起始位置
    if ([self.text containsString:@"1"]) {
        self.tempString = [self.text stringByReplacingOccurrencesOfString:@"1" withString:@"0"];
    } else if ([self.text containsString:@"*"]){//初始化默认的位置
        self.tempString = [self.text stringByReplacingOccurrencesOfString:@"*" withString:@"0"];
    }else{
        self.tempString = self.text;
    }
    CGRect commenRectPosition = [self getHeightLineWithString:self.tempString withWidth:self.bounds.size.width withFont:self.font];
    //    self.startPositionX = (self.bounds.size.width - (commenRectPosition.size.width + self.spaceWidth * 6)) * 0.5;
    self.startPositionX = (self.bounds.size.width - commenRectPosition.size.width ) * 0.5;
    self.OriginalPositionX = self.startPositionX;
    
    self.startPositionY = (self.bounds.size.height - commenRectPosition.size.height) * 0.5;
    _isGot = YES;
}

- (void)drawRect:(CGRect)rect {
    
    if (!_isGot) {//限制只执行一次获取位置信息的方法
        [self GetTextPositionMessage];
    }
    
    self.startPositionX = self.OriginalPositionX;//每次绘制,恢复startPositionX的位置
    
    //绘制文字
    [self DrawTextWithString:self.text];
}


//判断当前字符串是否是数字
static BOOL isPureInt (NSString* string){
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//获取字符串中的数字
- (NSString * )StringContainNumberWith:(NSString *)str {
    
    NSMutableArray *numArray = [[NSMutableArray alloc]init];
    
    NSString  *temp = nil;
    
    for (int i = 0; i < str.length; i ++) {
        
        temp = [str substringWithRange:NSMakeRange(i, 1)];
        
        if (isPureInt (temp)==YES) {
            
            [numArray addObject:temp];
            
        }
    }
    NSString *numStr = [numArray componentsJoinedByString:@","];
    NSString *num = [numStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    return num;
}

//将文字绘制到label上
-(void)DrawTextWithString:(NSString *)string{
    
    NSArray * textArray = [string componentsSeparatedByString:@" "];

    for (int i = 0; i < textArray.count; i ++) {
        NSString * singleNumStr = textArray[i];
        
        // 获得一个位图图形上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawPath(context,kCGPathStroke);
        NSDictionary *attributes = @{ NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.TextColor ? self.TextColor : DEFAULT_TEXT_COLOR};//文字的颜色
        
        if (i == 0) {
            [singleNumStr drawAtPoint:CGPointMake(self.startPositionX, self.startPositionY) withAttributes:attributes];
        }else{//下一个字符串绘制的位置,是相对于上一个字符串的位置和宽度进行绘制
            
            NSString * lastOnesingleNumStr = textArray[i - 1];
            
            //所有的数字,全部以0的宽度为基准
            if (isPureInt (lastOnesingleNumStr)==YES) {
                lastOnesingleNumStr = @"00";
            }
            
            CGSize textSize = [lastOnesingleNumStr boundingRectWithSize:CGSizeMake(self.bounds.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
            
            //计算每个字符串的X位置
            self.startPositionX += textSize.width +  self.spaceWidth;
            
            //判断字符串是否是数字
            if (isPureInt (singleNumStr)==YES) {
                
                //绘制数字的背景色
                CGRect newRect = CGRectMake(self.startPositionX - self.spaceWidth * 0.5, self.startPositionY + 0.5, self.NumWidth, self.NumHeight);
                UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:self.TextBackGroundCornerRadius ? self.TextBackGroundCornerRadius : DEFAULT_TEXT_CORNER_RADIUS];
                [self.TextBackGroundColor ? self.TextBackGroundColor : DEFAULT_TEXT_BACKGROUND_COLOR set];//背景框的颜色
                [path fill];
                attributes = @{ NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.DateColor ? self.DateColor : DEFAULT_DATE_COLOR};//时间的颜色
                
                if ([singleNumStr containsString:@"1"]) {
                    //判断数字中是否包含1,如果包含1的话,X坐标要多偏移一点
                    self.startPositionX += (self.NumWidth - [singleNumStr boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width - self.spaceWidth) * 0.5;
                    
                    [singleNumStr drawAtPoint:CGPointMake(self.startPositionX, self.startPositionY) withAttributes:attributes];
                    
                    //绘制完包含数字1的字符串后,减去X多偏移的数值
                    self.startPositionX -= (self.NumWidth - [singleNumStr boundingRectWithSize:CGSizeMake(self.bounds.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width - self.spaceWidth) * 0.5;
                    
                    //下边的两个else,是为了判断让包含数字1的字符串能够绘制在黑色框的正中心
                }else{
                    [singleNumStr drawAtPoint:CGPointMake(self.startPositionX, self.startPositionY) withAttributes:attributes];
                }
                
            }else{
                [singleNumStr drawAtPoint:CGPointMake(self.startPositionX, self.startPositionY) withAttributes:attributes];
            }
        }
        UIGraphicsEndImageContext();
    }
}

#pragma mark - 根据字符串计算label高度
- (CGRect)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    //1.3配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect;
}

@end
