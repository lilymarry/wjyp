//
//  UBTypePopCell.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UBTypePopCellStyle_img_lab,
    UBTypePopCellStyle_lab_underLine,
} UBTypePopCellStyle;

@interface UBTypePopCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *lineLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabLeft;



@property (nonatomic, assign) UBTypePopCellStyle showStyle;

+(void)xibWithCollectionView:(UITableView *)collectionView;
+(NSString *)cellIdentifier;

-(void)cellSettingWithShowType:(UBTypePopCellStyle)showType;

@end
