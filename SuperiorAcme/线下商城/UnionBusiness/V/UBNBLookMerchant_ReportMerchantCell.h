//
//  UBNBLookMerchant_ReportMerchantCell.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UBNB_LookMerchant = 0,
    UBNB_ReportMerchant,
} UBNBLookMerchant_ReportMerchantCell_type;

@interface UBNBLookMerchant_ReportMerchantCell : UITableViewCell

@property (nonatomic, assign) BOOL isShowArrow;

@property (weak, nonatomic) IBOutlet UILabel *rightTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLab;

@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHH;

@property (assign,nonatomic)UBNBLookMerchant_ReportMerchantCell_type type;

@end
