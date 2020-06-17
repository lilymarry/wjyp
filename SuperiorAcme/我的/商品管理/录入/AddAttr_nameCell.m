//
//  AddAttr_nameCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/14.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddAttr_nameCell.h"
@interface AddAttr_nameCell ()<UITextFieldDelegate>
{
    NSString *attr_id;
}
@end
@implementation AddAttr_nameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameTf.delegate=self;
    self.priceTf.delegate=self;
    self.jisuanPriceTf.delegate=self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadDic:(NSDictionary *)dic
{
    self.nameTf.text=dic[@"name"];
    self.priceTf.text=dic[@"price"];
    self.jisuanPriceTf.text=dic[@"jiesuan_price"];
    attr_id=dic[@"attr_id"];
    
    if ([dic[@"attr_id"] length]!=0) {
        self.nameTf.enabled=NO;
        self.priceTf.enabled=NO;
        self.jisuanPriceTf.enabled=NO;
        
    }
    else
    {
        self.nameTf.enabled=YES;
        self.priceTf.enabled=YES;
        self.jisuanPriceTf.enabled=YES;
    }
    

}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  
    switch (textField.tag) {
        case 1001:
             self.nameTf.text = textField.text;
            break;
        case 1002:
           self.priceTf.text = textField.text;
            break;

        case 1003:
            self.jisuanPriceTf.text = textField.text;
            break;
        
    }
    if (attr_id.length==0) {
        attr_id=@"";
    }
  
        NSDictionary * dic=@{@"attr_id":attr_id,@"name":self.nameTf.text,@"price":self.priceTf.text,@"jiesuan_price":self.jisuanPriceTf.text};
        if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(AddAttr_nameCell:index:)]) {
            [self.delgate AddAttr_nameCell:dic index:_index];
        }
   
    return YES;
}
- (IBAction)delePress:(id)sender {
    if (self.delgate!=nil&&[self.delgate respondsToSelector:@selector(deleAttr_nameCellIndex:)]) {
        [self.delgate deleAttr_nameCellIndex:_index];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;//此处是限制emoji表情输入
    }
    return YES;
    
}

@end
