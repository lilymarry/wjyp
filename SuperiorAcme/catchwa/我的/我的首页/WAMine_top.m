//
//  WAMine_top.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMine_top.h"

@interface WAMine_top ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation WAMine_top
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAMine_top" owner:self options:nil];
        [self addSubview:_thisView];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 15;
        _backView.layer.borderWidth = 0.1;
        _backView.layer.borderColor =[UIColor clearColor].CGColor;
        
        _headImaView.layer.masksToBounds = YES;
        _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
        _headImaView.layer.borderWidth = 0.1;
        _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
        
        NSString *str1 =@"10";
        NSString *str2 =@"我的银两";
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str1,str2]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:252/255.0 green:73/255.0 blue:155/255.0 alpha:1] range:NSMakeRange(0 , str1.length)];
         [_oneBtn setAttributedTitle:AttributedStr forState:UIControlStateNormal];
        
        NSString *str3 =@"2";
        NSString *str4 =@"我的娃娃";
        
        NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",str3,str4]];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:252/255.0 green:73/255.0 blue:155/255.0 alpha:1] range:NSMakeRange(0 , str3.length)];
        [_twoBtn setAttributedTitle:AttributedStr1 forState:UIControlStateNormal];
    
        
        _oneBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _oneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      
        _twoBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _twoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
     
        _oneBtn.tag = 1;
        [_oneBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
      
        _twoBtn.tag = 2;
        [_twoBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)btnEvent:(id)sender {
    UIButton * btn = (UIButton *)sender;
    NSInteger num = btn.tag;
    self.topBtnBlock(num);
}

@end
