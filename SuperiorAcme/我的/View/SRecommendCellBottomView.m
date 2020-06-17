//
//  SRecommendCellBottomView.m
//  NewTest
//
//  Created by 科技沃天 on 2018/5/4.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#define Scale 43/132
#define SELF_WIDTH self.bounds.size.width
#define SELF_HEIGHT self.bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCSa ScreenWidth/414
#define MARGIN 0 * SCSa

#import "SRecommendCellBottomView.h"

@interface SRecommendCellBottomView ()

@property (nonatomic, weak) UILabel * title_Label;
@property (nonatomic, weak) UIButton * topBtn;
@property (nonatomic, weak) UIButton * bottomBtn;

@end

@implementation SRecommendCellBottomView

#pragma mark - 系统回调
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreatSubView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self CreatSubView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.title_Label.frame = CGRectMake(0, 0, SELF_WIDTH * Scale, SELF_HEIGHT);
    self.topBtn.frame = CGRectMake(CGRectGetMaxX(self.title_Label.frame), MARGIN, SELF_WIDTH - CGRectGetWidth(self.title_Label.frame), (SELF_HEIGHT - 2 * MARGIN) * 0.5);
    self.bottomBtn.frame = CGRectMake(CGRectGetMinX(self.topBtn.frame), CGRectGetMaxY(self.topBtn.frame), CGRectGetWidth(self.topBtn.frame), CGRectGetHeight(self.topBtn.frame));
}
#pragma mark - 重写setter方法
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _title_Label.text = titleString;
}
-(void)setUmbrellaString:(NSString *)umbrellaString{
    _umbrellaString = umbrellaString;
    [_topBtn setAttributedTitle:[self ShowKindsOfColorWithString:[NSString stringWithFormat:@"%@人",umbrellaString]] forState:UIControlStateNormal];
}
-(void)setCodingString:(NSString *)codingString{
    _codingString = codingString;
    [_bottomBtn setAttributedTitle:[self ShowKindsOfColorWithString:[NSString stringWithFormat:@"%@人",codingString]] forState:UIControlStateNormal];
}
#pragma mark - 创建子控件
-(void)CreatSubView{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.text = @"无界";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.title_Label = titleLabel;
    
    UIButton * topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5 * SCSa);
    topButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * SCSa, 0, 0);
    topButton.userInteractionEnabled = NO;
    [topButton setImage:[UIImage imageNamed:@"雨伞-01(1)"] forState:UIControlStateNormal];
    [topButton setAttributedTitle:[self ShowKindsOfColorWithString:@"100人"] forState:UIControlStateNormal];
    topButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:topButton];
    self.topBtn = topButton;
    
    UIButton * bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5 * SCSa);
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5 * SCSa, 0, 0);
    bottomButton.userInteractionEnabled = NO;
    [bottomButton setImage:[UIImage imageNamed:@"资源1"] forState:UIControlStateNormal];
    [bottomButton setAttributedTitle:[self ShowKindsOfColorWithString:@"100人"] forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:bottomButton];
    self.bottomBtn = bottomButton;
}
#pragma mark - 设置不同字体
-(NSAttributedString *)ShowKindsOfColorWithString:(NSString *)string{

    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:236.0/255 green:28.0/255 blue:28.0/255 alpha:1.0] range:NSMakeRange(0, string.length)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0] range:NSMakeRange(string.length - 1, 1)];
    return attString;
}
@end
