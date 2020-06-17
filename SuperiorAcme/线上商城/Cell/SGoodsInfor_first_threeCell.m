//
//  SGoodsInfor_first_threeCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor_first_threeCell.h"

@implementation SGoodsInfor_first_threeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _roundR.layer.masksToBounds = YES;
    _roundR.layer.cornerRadius = _roundR.frame.size.width/2;
    
    _rightR.layer.masksToBounds = YES;
    _rightR.layer.cornerRadius = 3;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"南开华苑站 库存15 距您15km"];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, 2)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(13, 4)];
    _thistitle.attributedText = attributedStr;
}

@end
