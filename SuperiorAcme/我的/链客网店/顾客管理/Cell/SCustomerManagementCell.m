//
//  SCustomerManagementCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCustomerManagementCell.h"

@interface SCustomerManagementCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ShopKeeperLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *containView;

@end

@implementation SCustomerManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ShopKeeperLevelLabel.layer.borderWidth = 1;
    self.ShopKeeperLevelLabel.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:38.0/255.0 blue:0/255.0 alpha:1].CGColor;
    self.ShopKeeperLevelLabel.layer.cornerRadius = self.ShopKeeperLevelLabel.bounds.size.height * 0.5;
    self.ShopKeeperLevelLabel.layer.masksToBounds = YES;
    
    
    self.containView.layer.cornerRadius = 6;
    self.containView.layer.borderColor = [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1].CGColor;
    self.containView.layer.borderWidth = 0.5;
    self.containView.layer.masksToBounds = YES;
}

-(void)setIcon:(NSString *)icon{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:icon]
                           placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
}

-(void)setName:(NSString *)name{
    self.nickNameLabel.text = name;
}

- (void)setLevel:(NSString *)level{
    self.ShopKeeperLevelLabel.text = level;

}

-(void)setPrice:(NSString *)price{
    self.moneyLabel.text = price;
}

-(void)setTime:(NSString *)time{
    self.timeLabel.text = time;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
}


@end
