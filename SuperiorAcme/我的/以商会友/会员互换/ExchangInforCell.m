//
//  ExchangInforCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ExchangInforCell.h"

@implementation ExchangInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIma.layer.cornerRadius = self.headIma.bounds.size.width * 0.5;
    self.headIma.layer.masksToBounds = YES;
    
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.newsView.layer.cornerRadius =self.newsView.bounds.size.width * 0.5;
    self.newsView.layer.masksToBounds = YES;
    
    
    UIColor *color1=[UIColor colorWithRed:233/255.0 green:114/255.0 blue:26/255.0 alpha:1];
     UIColor *color2=[UIColor colorWithRed:115/255.0 green:191/255.0 blue:244/255.0 alpha:1];
     UIColor *color3=[UIColor colorWithRed:242/255.0 green:215/255.0 blue:37/255.0 alpha:1];
     UIColor *color4=[UIColor colorWithRed:162/255.0 green:42/255.0 blue:199/255.0 alpha:1];
    NSArray *arr=[NSArray arrayWithObjects:color1,color2,color3,color4, nil];
    
    srand((unsigned)time(0)); //不加这句每次产生的随机数不变
    int i = rand() % 4;
    [self.lineView setBackgroundColor:arr[i]];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
