//
//  SEvaAllCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaAllCell.h"
#import "SOnlineShop_ClassInfoList_more_footerCont.h"

@interface SEvaAllCell ()
{
    SOnlineShop_ClassInfoList_more_footerCont * con;
}
@end

@implementation SEvaAllCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    con = [[SOnlineShop_ClassInfoList_more_footerCont alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 30, 60)];
    [_thisContent addSubview:con];
    
    _head_pic.layer.masksToBounds = YES;
    _head_pic.layer.cornerRadius = _head_pic.frame.size.width/2;
}
- (void)showModel:(NSArray *)arr andType:(NSString *)type{
    [con showModel:arr andPriceShow:NO andType:type];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
