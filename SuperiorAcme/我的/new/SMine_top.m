//
//  SMine_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMine_top.h"

@implementation SMine_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SMine_top" owner:self options:nil];
        [self addSubview:_thisView];
      
        _scrollView.contentSize=CGSizeMake(646,80 );
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
        _headerImage.layer.borderWidth = 0.5;
        _headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _oneView.layer.masksToBounds = YES;
        _oneView.layer.cornerRadius = 12.5;
        _twoView.layer.masksToBounds = YES;
        _twoView.layer.cornerRadius = 12.5;
        
        _oneImage.layer.masksToBounds = YES;
        _oneImage.layer.cornerRadius = _oneImage.frame.size.width/2;
        
        _twoImage.layer.masksToBounds = YES;
        _twoImage.layer.cornerRadius = _twoImage.frame.size.width/2;
        
        //会员成长
        _oneBtn.tag = 1;
        [_oneBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        //会员等级
        _twoBtn.tag = 2;
        [_twoBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //积分
        _fourBtn.tag = 3;
        [_fourBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        //余额
        _threeBtn.tag = 4;
        [_threeBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        //购物券
        _fiveBtn.tag = 5;
        [_fiveBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        //银两
        _sixBtn.tag = 6;
        [_sixBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        //赠品券
        _sevenBtn.tag = 7;
        [_sevenBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
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
-(void)setValue:(SUserUserCenter *)center {
    _nickname.text = center.data.nickname;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:center.data.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    [_oneImage sd_setImageWithURL:[NSURL URLWithString:center.data.rank_icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    _oneNick.text = center.data.rank;
    [_twoImage sd_setImageWithURL:[NSURL URLWithString:center.data.level_icon] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    _twoNick.text = center.data.level;
    [_mOneImage sd_setImageWithURL:[NSURL URLWithString:center.data.is_gold_a]];
   
    [_mTwoImage sd_setImageWithURL:[NSURL URLWithString:center.data.is_silver_a]];
    [_mThreeImage sd_setImageWithURL:[NSURL URLWithString:center.data.is_copper_a]];
    [_mFourImage sd_setImageWithURL:[NSURL URLWithString:center.data.is_masonry_a]];
    [_mFiveImage sd_setImageWithURL:[NSURL URLWithString:center.data.is_iron_a]];
    _lastTime.text = center.data.point_date;
    
    _threeNum.text = center.data.balance;
    _fourNum.text = center.data.integral;
    _fiveNum.text = center.data.ticket_num;
    _sixNum.text=center.data.chance_num;
    _sevenNum.text=center.data.gift_num;
    
    
    //字体加粗
     _threeNum.font = [UIFont boldSystemFontOfSize:14];
     _fourNum.font = [UIFont boldSystemFontOfSize:14];
     _fiveNum.font = [UIFont boldSystemFontOfSize:14];
     _sixNum.font = [UIFont boldSystemFontOfSize:14];
     _sevenNum.font = [UIFont boldSystemFontOfSize:14];
    
    //                [_lastBtn setTitle:[NSString stringWithFormat:@"无界指数 %@",center.data.point_num] forState:UIControlStateNormal];
}

- (void)viewIsShow:(BOOL)isNo {
    if (isNo == NO) {
        _oneView.hidden = YES;
        _twoView.hidden = YES;
        _nickname_HHH.constant = 60;
    } else {
        _oneView.hidden = NO;
        _twoView.hidden = NO;
        _nickname_HHH.constant = 30;
    }
}

@end
