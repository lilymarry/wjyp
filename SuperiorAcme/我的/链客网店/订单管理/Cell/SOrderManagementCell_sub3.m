//
//  SOrderManagementCell_sub3.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderManagementCell_sub3.h"

@implementation SOrderManagementCell_sub3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.degreeBtn.layer.borderWidth = 1;
    self.degreeBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.degreeBtn.layer.masksToBounds = YES;
    self.degreeBtn.layer.cornerRadius = 12;
    
    self.disgreeBtn.layer.borderWidth = 1;
    self.disgreeBtn.layer.borderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1].CGColor;
    self.disgreeBtn.layer.masksToBounds = YES;
    self.disgreeBtn.layer.cornerRadius = 12;
    _tf_huangJuanNum.delegate =self;
    
    self.wuliuBtn.layer.borderWidth = 1;
    self.wuliuBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.wuliuBtn.layer.masksToBounds = YES;
    self.wuliuBtn.layer.cornerRadius = 12;
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text doubleValue]>[_ticket_lines doubleValue]) {
        textField.text=[NSString stringWithFormat:@"%.2f",[_ticket_lines doubleValue]];
    }
   // NSLog(@"cdfdsfdsf %@",textField.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)degreePress:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(degreeBtnClick:andtxf:ticket_line:)]){
        if (_tf_huangJuanNum.text.length==0) {
              [MBProgressHUD showSuccess:@"数量不能为空" toView:self.superview];
        }
        else
        {
        NSString *str=    [NSString stringWithFormat:@"%.2f",[_ticket_lines doubleValue]];
        [_delegate degreeBtnClick:_model andtxf:_tf_huangJuanNum.text ticket_line:str];
        }}
}
- (IBAction)disgreePress:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(disgreeBtnClick:andtxf:ticket_line:)]){
        if (_tf_huangJuanNum.text.length==0) {
              [MBProgressHUD showSuccess:@"数量不能为空" toView:self.superview];
        }
        else
        {
             NSString *str=    [NSString stringWithFormat:@"%.2f",[_ticket_lines doubleValue]];
        [_delegate disgreeBtnClick:_model andtxf:_tf_huangJuanNum.text ticket_line:str];
        }}
}
- (IBAction)wuliuClick:(UIButton *)sender {
    if (self.wuliuBlock) {
        self.wuliuBlock();
    }
}

@end
