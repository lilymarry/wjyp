//
//  SOpenShopGoodManagementCell.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareOpenShopGoodBlock)();

@interface SOpenShopGoodManagementCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levImagView;

@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
@property (nonatomic, copy) ShareOpenShopGoodBlock shareOpenShopGood;

@end
