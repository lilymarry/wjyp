//
//  ReLayoutSubViewButton.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ReLayoutSubViewButton.h"

@interface ReLayoutSubViewButton ()
@property (nonatomic, assign) CGFloat imageWH;
@end

@implementation ReLayoutSubViewButton

-(void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.font.pointSize * (ScreenW / 414.0)];
    self.interTitleImageSpacing = 5;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageWH = self.imageView.bounds.size.width * (ScreenW / 414.0);
    self.imageView.frame = CGRectMake((self.bounds.size.width - self.imageWH) * 0.5, self.interTitleImageSpacing, self.imageWH, self.imageWH);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.interTitleImageSpacing * 0.5, self.bounds.size.width, self.titleLabel.bounds.size.height);
}


-(void)setInterTitleImageSpacing:(CGFloat)interTitleImageSpacing{
    
    _interTitleImageSpacing = interTitleImageSpacing * (ScreenW / 414.0);
    
    //不是默认值的时候,重新布局
    if (interTitleImageSpacing != 5) {
        [self layoutIfNeeded];
    }
    
}

-(void)setHighlighted:(BOOL)highlighted{}
@end
