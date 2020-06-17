//
//  SGroupBuyLuckHandListCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SGroupBuyLuckHandListCell.h"

@implementation SGroupBuyLuckHandListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _ima_head.layer.masksToBounds = YES;
    _ima_head.layer.cornerRadius = _ima_head.frame.size.width/2;
    _ima_head.layer.borderWidth = 0.5;
    _ima_head.layer.borderColor = [UIColor whiteColor].CGColor;
    
}

@end
