//
//  UBNBLookMerchant_ReportMerchantCell.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNBLookMerchant_ReportMerchantCell.h"

@implementation UBNBLookMerchant_ReportMerchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setType:(UBNBLookMerchant_ReportMerchantCell_type)type{
    _type = type;
    switch (type) {
        case UBNB_LookMerchant:
            {
                self.rightTitleLab.hidden = YES;
//                self.rightArrowImgV.hidden = YES;
            }
            break;
        case UBNB_ReportMerchant:
        {
            self.rightTitleLab.hidden = NO;
            self.rightArrowImgV.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

-(void)setIsShowArrow:(BOOL)isShowArrow{
    _isShowArrow = isShowArrow;
    self.rightArrowImgV.hidden = _isShowArrow;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
