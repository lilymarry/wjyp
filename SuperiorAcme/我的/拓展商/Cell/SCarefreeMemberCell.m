//
//  SCarefreeMemberCell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCarefreeMemberCell.h"

@implementation SCarefreeMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisTime.layer.masksToBounds = YES;
    _thisTime.layer.cornerRadius = 3;
}

-(void)fullDataWithModel:(SGoodsGoodsList *)model{
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.goods_img]
                 placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    self.contentLab.text = model.goods_name;
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",model.shop_price];
}

@end
