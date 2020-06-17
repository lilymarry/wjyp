//
//  CompleteUserView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CompleteUserView.h"

@interface CompleteUserView ()
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;


@end

@implementation CompleteUserView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CompleteUserView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
        
        _sureBtn.layer.borderWidth = 1;
        _sureBtn.layer.borderColor = [UIColor redColor].CGColor;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 12;
        
        _titlelab.text=@"完善个人资料就可以获得0代金券!";
        _moneyLab.text=@"0";
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)setMoney:(NSString *)money
{
    _titlelab.text=[NSString stringWithFormat:@"完善个人资料就可以获得%@代金券!",money];
    _moneyLab.text=money;
    
    
}
- (IBAction)cancell:(id)sender {
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (IBAction)surePress:(id)sender {
    
    [self cancell:nil];
    if (self.block) {
        self.block();
    }
    
}



@end
