//
//  AddSpecs_nameContentCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/15.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddSpecs_nameContentCell.h"
@interface AddSpecs_nameContentCell ()<UITextFieldDelegate>
{
    NSString *bid;
    
}
@end
@implementation AddSpecs_nameContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentTf.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)reloadData:(NSDictionary *)dic
{
    self.contentTf.text=dic[@"name"];
    bid=dic[@"bid"];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    if (bid.length==0) {
        bid=@"";
    }
    NSDictionary * dic=@{@"bid":bid,@"name":textField.text};
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(AddSpecs_nameCell:index:)]) {
        [self.delgate AddSpecs_nameCell:dic index:_index];
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

- (IBAction)delePress:(id)sender {
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(deleSpecs_nameIndex:)]) {
        [self.delgate deleSpecs_nameIndex:_index];
    }
    
    
}

@end
