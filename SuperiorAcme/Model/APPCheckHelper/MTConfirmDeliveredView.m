//
//  MTConfirmDeliveredView.m
//  DinnerDistribution
//
//  Created by nian on 2017/12/1.
//  Copyright © 2017年 hanshanquan. All rights reserved.
//

//颜色宏定义
#define UIColorHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
//33
#define COLOR_33  UIColorHex(0x333333)

#define Font(x) [UIFont systemFontOfSize:(x)]

#define AUTO_SCALE_H(num)         (KIphoneSize_Widith(num))
#define AUTO_SCALE_W(num)         (KIphoneSize_Height(num))

/**
 *  调用 KIphoneSize_Widith(100) 6的宽度 会根据456给出不同宽度，
 高度同上
 *  @param iphone6p/7p 100*1.104
 *  @param iphone6/7  100
 *  @param iphone5s 100*0.853
 *  @param iphone4s 100*0.853
 *  @return
 */
//适配宏 根据屏幕尺寸来判断当前手机型号
#define KScreenSize [UIScreen mainScreen].bounds.size
#define IsIphone6P KScreenSize.width==414
#define IsIphone6 KScreenSize.width==375
#define IsIphone5S KScreenSize.height==568
//456字体大小  KIOS_Iphone456(iphone6p,iphone6,iphone5s,iphone4s)
//#define KIOS_Iphone456(iphone6p,iphone6,iphone5s,iphone4s) (IsIphone6P?iphone6p:(IsIphone6?iphone6:(IsIphone5S?iphone5s:iphone4s)))
//宽  KIphoneSize_Widith(iphone6)  高 KIphoneSize_Height(iphone6)
#define KIphoneSize_Widith(iphone6)  (IsIphone6P?1.104*iphone6:(IsIphone6?iphone6:(IsIphone5S?0.853*iphone6:0.853*iphone6)))
#define KIphoneSize_Height(iphone6)  (IsIphone6P?1.103*iphone6:(IsIphone6?iphone6:(IsIphone5S?0.851*iphone6:0.720*iphone6)))

#define MAIN_THEME_COLOR [UIColor redColor]

#import "MTConfirmDeliveredView.h"


@implementation MTConfirmDeliveredView

- (id)initWithTitle:(NSString *)title content:(NSString *)content btnTitles:(NSArray *)btnTitles type:(MTConfirmDeliveredViewType)type{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.501];
        self.cusTitle = title;
        self.cusContent = content;
        self.cusBtnsTitle = btnTitles;
        self.type = type;
        [self viewSetting];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.501];
        
    [self viewSetting];
        
    }
    return self;
}

- (void)viewSetting{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestuer:)];
//    [self addGestureRecognizer:tap];
    
//    [self viewShow];
    
    //容器
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 3;
    contentView.clipsToBounds = YES;
    [self addSubview:_contentView = contentView];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = self.cusTitle;
    titleLab.textColor = COLOR_33;
    titleLab.font = Font(16);
    [_contentView addSubview:titleLab];
    
    UILabel *lineLab = [UILabel new];
    lineLab.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [_contentView addSubview:lineLab];
    
    //tipLab
    UILabel *tipLab = [UILabel new];
    tipLab.text = self.cusContent;
    tipLab.textColor = COLOR_33;
    tipLab.numberOfLines = 3;
    tipLab.textAlignment = 1;
    tipLab.font = Font(16);
    [_contentView addSubview:tipLab];
    
    NSArray *titles = self.cusBtnsTitle;
    UIButton *weiYueDingBtn,*yiYueDingBtn;
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button.titleLabel setFont:Font(14)];
        [button.layer setCornerRadius:5];
        [button setClipsToBounds:YES];
        button.tag = 100 + i;
        [button addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:1<<6];
        if (i == 0) {
          [button.layer setBorderColor:MAIN_THEME_COLOR.CGColor];
          [button.layer setBorderWidth:.5];
          [button setBackgroundColor:[UIColor whiteColor]];
          [button setTitleColor:MAIN_THEME_COLOR forState:0];
            weiYueDingBtn = button;
        }else{
           [button setBackgroundColor:MAIN_THEME_COLOR];
           [button setTitleColor:[UIColor whiteColor] forState:0];
            yiYueDingBtn = button;
        }
        [_contentView addSubview:button];
    }
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(AUTO_SCALE_W(280));
        make.height.mas_equalTo(AUTO_SCALE_H(175));
    }];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(AUTO_SCALE_H(10));
    }];
    
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
    }];
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineLab.mas_bottom).offset(AUTO_SCALE_H(17));
        make.left.mas_equalTo(AUTO_SCALE_W(33));
        make.right.mas_equalTo(-AUTO_SCALE_W(33));
    }];
    
    
    
    if (self.type == MTConfirmDeliveredViewType_QiangZhiGengXin) {
        [weiYueDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AUTO_SCALE_W(20));
            make.bottom.mas_equalTo(-AUTO_SCALE_H(11));
            make.height.mas_equalTo(AUTO_SCALE_H(33));
            make.right.mas_equalTo(-AUTO_SCALE_W(20));
        }];
    }else{
        [weiYueDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AUTO_SCALE_W(20));
            make.bottom.mas_equalTo(-AUTO_SCALE_H(11));
            make.height.mas_equalTo(AUTO_SCALE_H(33));
        }];
        
        [yiYueDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-AUTO_SCALE_W(20));
            make.bottom.height.mas_equalTo(weiYueDingBtn);
            make.left.mas_equalTo(weiYueDingBtn.mas_right).offset(12);
            make.width.mas_equalTo(weiYueDingBtn);
        }];
    }
    
}

- (void)buttonAction:(UIButton *)btn{
    switch (btn.tag) {
        case 100://强制更新  // 取消
            {
                if(_type == MTConfirmDeliveredViewType_QiangZhiGengXin){
                    if (self.delegate && [self.delegate respondsToSelector:@selector(qiangZhiGengXinMethod)]) {
                        [_delegate qiangZhiGengXinMethod];
                    }
                }
                
                if (_type == MTConfirmDeliveredViewType_ChangeAddress) {
                    //更新地址
                    if (self.delegate && [self.delegate respondsToSelector:@selector(notChangeAddressMethod)]) {
                        [_delegate notChangeAddressMethod];
                    }
                }else{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(quXiaoGengxinMethod)]) {
                        [_delegate quXiaoGengxinMethod];
                    }
                }
            }
            break;
        case 101://更新
        {
            if(_type == MTConfirmDeliveredViewType_NormalGengXin){
                if (self.delegate && [self.delegate respondsToSelector:@selector(gengxinMethod)]) {
                    [_delegate gengxinMethod];
                }
            }
            
        }
            break;
        default:
            break;
    }
    
    if (self.type != MTConfirmDeliveredViewType_QiangZhiGengXin){
        [self viewDismiss];
    }
    
}

- (void)viewShow{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {}];
}

- (void)tapGestuer:(UITapGestureRecognizer *)tap{
    [self viewDismiss];
}

- (void)viewDismiss{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
