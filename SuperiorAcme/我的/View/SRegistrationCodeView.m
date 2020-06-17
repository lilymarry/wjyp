//
//  SRegistrationCodeView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegistrationCodeView.h"
#import "SUserGetSignCode.h"

/*
 *修改生成二维码的字符串将"code"改为"invite_code"
 */
#define QRCodeSubStr(codeContent,typeNum) [NSString stringWithFormat:@"User/mentorship/invite_code/%@/type/%lu",codeContent,typeNum]

@interface SRegistrationCodeView ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *SelectQRCodeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GroundViewToTrailingCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *GroundViewToLeadingCons;

@end

@implementation SRegistrationCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SRegistrationCodeView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 3;
        
        _header_pic.layer.masksToBounds = YES;
        _header_pic.layer.cornerRadius = _header_pic.frame.size.width/2;
        

        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SRegistrationCodeViewBack) {
        self.SRegistrationCodeViewBack();
    }
}

/*
 *根据传入的二维码类型,设置显示隐藏selecQRCodeView以及底部的tipLabel的问题
 */
-(void)setQRCodeType:(NSString *)QRCodeType{
    _QRCodeType = QRCodeType;
    if ([QRCodeType isEqualToString:@"注册码"]) {
        self.tipLabel.text = @"扫描二维码注册无界会员";
        self.SelectQRCodeView.hidden = YES;
    } else if ([QRCodeType isEqualToString:@"拜师码"]){
        self.tipLabel.text = @"扫描二维码进行拜师";
        self.SelectQRCodeView.hidden = NO;
    } else if ([QRCodeType isEqualToString:@"商家码"]){
        self.tipLabel.text = @"点击下载放到线下进行扫码支付";
        self.SelectQRCodeView.hidden = NO;
    }
}

/*
 *根绝传入的二维码数,创建按钮
 */
-(void)setTrainerArr:(NSArray *)TrainerArr{
    _TrainerArr = TrainerArr;
    if (TrainerArr.count > 0) {
        [self CreatSelectQRCodeButtonWithCount:TrainerArr.count];        
    }
}

-(void)CreatSelectQRCodeButtonWithCount:(NSUInteger)QRCodeCount{
    CGFloat Margin = 0.0;
    CGFloat btnW = 0.0;
    if (QRCodeCount > 1) {
        Margin = 0.5;
        btnW = (ScreenW - _GroundViewToLeadingCons.constant - _GroundViewToTrailingCons.constant - Margin) * 0.5;
    }else{
        Margin = 0.0;
        btnW = (ScreenW - _GroundViewToLeadingCons.constant - _GroundViewToTrailingCons.constant - Margin);
    }
    CGFloat btnH = self.SelectQRCodeView.bounds.size.height;
    for (int i = 0 ; i < QRCodeCount; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((btnW + 1)* i, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor colorWithRed:30.0/255 green:30.0/255 blue:30.0/255 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitle:self.TrainerArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ShowQRCode:) forControlEvents:UIControlEventTouchUpInside];
        [self.SelectQRCodeView addSubview:btn];
    }
    [self ShowQRCode:self.SelectQRCodeView.subviews.firstObject];
}

-(void)ShowQRCode:(UIButton *)sender{

    NSArray *array = sender.superview.subviews;
    if (array.count > 1){
        for (UIButton *btn in array) {
            if (btn != sender) {
                btn.selected = FALSE;
            } else {
                btn.selected = TRUE;
            }
        }
    }
    
    NSUInteger typeNum = 0;
    if ([sender.titleLabel.text isEqualToString:self.member_trainer]) {//会员拜师  1
        typeNum = 1;
    } else if ([sender.titleLabel.text isEqualToString:self.merchant_trainer]){//商家拜师  2
        typeNum = 2;
    } else if ([sender.titleLabel.text isEqualToString:@"商家码"]) {
        typeNum = 3;
    }
    
    NSString * QRCodeStr = @"";
    
    if (typeNum != 3) {
        QRCodeStr = [NSString stringWithFormat:@"%@%@",BaiShi_Base_url,QRCodeSubStr(self.code, typeNum)];
    } else {
        QRCodeStr = Merchant_Base_url(_stage_merchant_id);
    }
    
    if (self.passQRCodeStrBlock) {
        self.passQRCodeStrBlock(QRCodeStr);
    }
}


@end
