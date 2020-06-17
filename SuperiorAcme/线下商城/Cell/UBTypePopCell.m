//
//  UBTypePopCell.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBTypePopCell.h"
#import <Masonry.h>

@implementation UBTypePopCell

-(void)cellSettingWithShowType:(UBTypePopCellStyle)showType{
    self.showStyle = showType;
    switch (self.showStyle) {
        case UBTypePopCellStyle_img_lab:
        {
            _lineLab.hidden = YES;
//            self.contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.1];
        }
            break;
        case UBTypePopCellStyle_lab_underLine:
        {
            _logo.hidden = YES;
            _contentLabLeft.constant = 0;
        }
            break;
            
        default:
            break;
    }
}

+(void)xibWithCollectionView:(UITableView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[[self class] cellIdentifier] bundle:nil]
         forCellReuseIdentifier:[[self class] cellIdentifier]];
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
