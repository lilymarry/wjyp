//
//  SATotleKindsCell.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SATotleKindsCell.h"

@implementation SATotleKindsCell

-(void)setPickUpModel:(SShopPickUpModel *)pickUpModel{
    _pickUpModel = pickUpModel;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_pickUpModel.isClicked) {
            self.titleLab.layer.borderColor = [UIColor redColor].CGColor;
            self.titleLab.layer.borderWidth = 1;
            self.titleLab.textColor = [UIColor redColor];
            self.titleLab.backgroundColor = [UIColor whiteColor];
        }else{
            self.titleLab.textColor = UIColorHex(0x333333);
            self.titleLab.layer.borderWidth = 0;
            self.titleLab.backgroundColor = UIColorHex(0xF6F6F6);
        }
    });
    
    self.titleLab.text = _pickUpModel.name;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (ScreenW > 320) {
        self.titleLab.font = [UIFont systemFontOfSize:15];
    }
    self.titleLab.layer.cornerRadius = 25 / 2.0;
    
    self.titleLab.clipsToBounds = YES;
    
    self.titleLab.userInteractionEnabled = YES;
    
}

@end
