//
//  DynamicAlertMes.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "DynamicAlertMes.h"

@implementation DynamicAlertMes

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (frame.size.height - 30) / 2, 30, 30)];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 15;
        [self addSubview:_avatarImageView];
        
        self.nickNameLabel = [[UILabel alloc] init];
        self.nickNameLabel.font = [UIFont systemFontOfSize:13];
        self.nickNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nickNameLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:13];
        self.contentLabel.textColor = [UIColor whiteColor];
        [self addSubview:_contentLabel];
        
    }
    return self;
}

/**
 给UI控件赋值
 
 @param data 数据包
 */
- (void)settingValues:(NSDictionary *)data {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:data[@"head_pic"]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    CGSize nameSize = [self autoSizeOfSignelLineText:data[@"nick_name"] font:[UIFont systemFontOfSize:13]];
    CGSize contentSize = [self autoSizeOfSignelLineText:data[@"msg"] font:[UIFont systemFontOfSize:13]];
    self.nickNameLabel.frame = CGRectMake(_avatarImageView.frame.origin.x +_avatarImageView.frame.size.width + 5, (self.frame.size.height - 30) / 2, nameSize.width + 7, 30);
    
    CGFloat maxWidth = self.superview.frame.size.width * 0.7;
    CGFloat leftWidth = self.nickNameLabel.frame.origin.x + self.nickNameLabel.frame.size.width;
    CGFloat maxRightWidth = maxWidth - leftWidth;
    CGFloat updateWidth = contentSize.width + 5;
    CGFloat rightWidth = updateWidth >= maxRightWidth ? maxRightWidth : updateWidth;
    
    self.contentLabel.frame = CGRectMake(_nickNameLabel.frame.origin.x +_nickNameLabel.frame.size.width, (self.frame.size.height - 30) / 2, rightWidth, 30);
    self.nickNameLabel.text = data[@"nick_name"];
    self.contentLabel.text = data[@"msg"];
    
    CGRect frame = self.frame;
    frame.size.width = self.contentLabel.frame.origin.x + self.contentLabel.frame.size.width + 5;
    self.frame = frame;
}

- (CGSize)autoSizeOfSignelLineText:(NSString *)text font:(UIFont *)font
{
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    return textSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
