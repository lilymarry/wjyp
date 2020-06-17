//
//  SCommonGoodManagementCell.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGoodManagementModel;

typedef void(^ShareCommonGoodBlock)();
typedef void(^recommendCommonGoodBlock)();
@interface SCommonGoodManagementCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *goodSelectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodAviliableCashCouponLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodGiveIntegralLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodShareBtn;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (nonatomic, copy) ShareCommonGoodBlock shareCommonGood;
@property (nonatomic, copy) recommendCommonGoodBlock recommendCommonGood;
@property (nonatomic, strong) SGoodManagementModel * goodManageModel;
@property (weak, nonatomic) IBOutlet UIImageView *jianImagView;
@property (weak, nonatomic) IBOutlet UIButton *jianBtn;

@end
