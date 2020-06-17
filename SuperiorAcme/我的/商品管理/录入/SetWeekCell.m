//
//  SetWeekCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SetWeekCell.h"
@interface SetWeekCell ()<UITextFieldDelegate>

@end
@implementation SetWeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contextTf.delegate=self;
    self.subContextTf.delegate=self;
    self.contextTf.tag=300;
    self.subContextTf.tag=301;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag==300) {
        self.contextTf.text=textField.text;
    }
    else
    {
       self.subContextTf.text=textField.text;
    }
    
    NSDictionary * dic=@{@"price":self.contextTf.text,@"jiesuan_price":self.subContextTf.text};
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(setWeekCell:index:)]) {
        [self.delgate setWeekCell:dic index: _index];
    }
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}

@end
