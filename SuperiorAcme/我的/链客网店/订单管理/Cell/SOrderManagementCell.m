//
//  SOrderManagementCell.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderManagementCell.h"

@implementation SOrderManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topView.layer.shadowOpacity = 1;
    self.topView.layer.shadowRadius = 3;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1].CGColor;
    
    self.topViewLeftBtn.layer.borderWidth = 1;
    self.topViewLeftBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.topViewLeftBtn.layer.masksToBounds = YES;
    self.topViewLeftBtn.layer.cornerRadius = 12;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
