//
//  SHouseInforCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInforCell.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"

@interface SHouseInforCell ()
{
    SOnlineShop_ClassInfoList_more_footerCont * con;
}
@end

@implementation SHouseInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
    
    con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 30, 60)];
    [_thisContent addSubview:con];
}

- (void)showModel:(NSArray *)arr andPriceShow:(BOOL)show_isno andType:(NSString *)model_type{
    [con showModel:arr andPriceShow:NO andType:model_type];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
