//
//  SSetShopNameCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SSetShopNameCell.h"

@interface SSetShopNameCell ()
@property (weak, nonatomic) IBOutlet UITextField *shopNameTextField;
@end

@implementation SSetShopNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextFieldEditStatus:) name:@"EditSelect" object:nil];
}

-(void)changeTextFieldEditStatus:(NSNotification *)noti{
    BOOL selected = [noti.userInfo[@"EditSelect"] boolValue];
    if (selected) {
        self.shopNameTextField.enabled = YES;
        [self.shopNameTextField becomeFirstResponder];
    }else{
        self.shopNameTextField.enabled = NO;
        [self.shopNameTextField resignFirstResponder];
        
        if (self.textFieldEndEditBlock) {
        self.textFieldEndEditBlock(self.shopNameTextField.text);
        }
    }
}

-(void)setShopName:(NSString *)shopName{
    _shopName = shopName;
    self.shopNameTextField.text = shopName;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
