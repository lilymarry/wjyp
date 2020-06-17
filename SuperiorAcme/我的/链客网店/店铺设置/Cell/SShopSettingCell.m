//
//  SShopSettingCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopSettingCell.h"

@implementation SShopSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectShopIconImage:) name:@"EditSelect" object:nil];
}

-(void)SelectShopIconImage:(NSNotification *)noti{
    BOOL selected = [noti.userInfo[@"EditSelect"] boolValue];
    if (selected) {
        self.userInteractionEnabled = YES;
    }else{
        self.userInteractionEnabled = NO;
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
}
@end
