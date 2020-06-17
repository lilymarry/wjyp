//
//  SCommonGoodManagementCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCommonGoodManagementCell.h"
#import "SGoodManagementModel.h"

@interface SCommonGoodManagementCell ()


@end

@implementation SCommonGoodManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.goodAviliableCashCouponLabel.layer.cornerRadius = 2;
    self.goodAviliableCashCouponLabel.layer.borderWidth = 1;
    self.goodAviliableCashCouponLabel.layer.borderColor = [UIColor colorWithRed:251.996/255.0 green:101.003/255.0 blue:93.9981/255.0 alpha:1].CGColor;
}

//-(void)setGoodManageModel:(SGoodManagementModel *)goodManageModel{
//    _goodManageModel = goodManageModel;
//    if (goodManageModel.isturnEditStatus) {
//        [UIView animateWithDuration:0.2 animations:^{
//            CGRect rect = self.containView.frame;
//            rect.origin.x = 50;
//            self.containView.frame = rect;
//        }];
//    }else{
//        [UIView animateWithDuration:0.2 animations:^{
//            CGRect rect = self.containView.frame;
//            rect.origin.x = 0;
//            self.containView.frame = rect;
//        }];
//    }
//
//    self.goodSelectBtn.selected = goodManageModel.isSelect;
//}

- (IBAction)shareCommonGoodClick:(UIButton *)sender {
    if (self.shareCommonGood) {
        self.shareCommonGood();
    }
}
- (IBAction)recomendClick:(id)sender {
    if (self.recommendCommonGood) {
        self.recommendCommonGood();
    }
}


@end
