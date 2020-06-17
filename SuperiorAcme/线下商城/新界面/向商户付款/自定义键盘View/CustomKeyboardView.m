//
//  CustomKeyboardView.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CustomKeyboardView.h"

@implementation CustomKeyboardView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        self.frame = frame;
        for (UIButton * btn in self.subviews) {
            if (101 == btn.tag) {//撤销按钮
                [btn addTarget:self action:@selector(revocationInput:) forControlEvents:UIControlEventTouchUpInside];
            }else if (102 == btn.tag){//确认付款按钮
                [btn addTarget:self action:@selector(payMoney:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [btn addTarget:self action:@selector(inputMoney:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    return self;
}
//输入金额
-(void)inputMoney:(UIButton *)btn{
    if (self.ClickNumCallBackBlcok) {
        self.ClickNumCallBackBlcok(btn.titleLabel.text);
    }
}
//撤销输入
-(void)revocationInput:(UIButton *)btn{
    if (self.RevocationCallBackBlock) {
        self.RevocationCallBackBlock();
    }
}
//确认付款
-(void)payMoney:(UIButton *)btn{
    if (self.PayMoneyCallBackBlock) {
        self.PayMoneyCallBackBlock();
    }
}
@end
