//
//  SShopCarCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCarCell.h"
@interface SShopCarCell () <UITextFieldDelegate>
@end

@implementation SShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //减
    [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //加
    [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //编辑
    [_editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //选中
    [_RBtn addTarget:self action:@selector(RBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    _numTF.delegate = self;
}
- (void)leftBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(leftCell:leftBtn:)]) {
        [_delegate leftCell:self leftBtn:btn];
    }
}
- (void)rightBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(rightCell:rightBtn:)]) {
        [_delegate rightCell:self rightBtn:btn];
    }
}
- (void)editBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(editCell:editBtn:)]) {
        [_delegate editCell:self editBtn:btn];
    }
}
- (void)RBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(RBtnCell:RBtn:)]) {
        [_delegate RBtnCell:self RBtn:btn];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(editNumCell:editNumTF:)]) {
        [_delegate editNumCell:self editNumTF:textField];
    }
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
