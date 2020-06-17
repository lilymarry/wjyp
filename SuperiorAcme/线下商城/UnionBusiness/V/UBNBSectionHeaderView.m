//
//  UBNBSectionHeaderView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNBSectionHeaderView.h"

@implementation UBNBSectionHeaderView

+(instancetype)instanceWithXIB{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

-(void)settingLefetTitle:(NSString *)leftTitle
              rightTitle:(NSString *)rightTitle{
    if ([rightTitle isEqualToString:@""]) {
        self.rightArrowImgV.hidden = YES;
        self.pingFenLab.hidden = YES;
    }else{
        self.rightArrowImgV.hidden = NO;
        self.pingFenLab.hidden = NO;
        self.pingFenLab.text = rightTitle;
        //文字处理啥的 ...
    }
    
    self.leftTitle.text = leftTitle;
    
}

-(void)discribeTextSettingWithText:(NSString *)text replaceText:(NSString *)replaceText{
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length-replaceText.length, replaceText.length)];
    self.pingFenLab.attributedText = AttributedStr;
    
}

+(CGFloat)viewHeight{
    return 63;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
