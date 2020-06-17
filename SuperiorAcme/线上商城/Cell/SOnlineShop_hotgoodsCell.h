//
//  SOnlineShop_hotgoodsCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SOnlineShop_hotgoodsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *googImag;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab_use_voucher;
@property (weak, nonatomic) IBOutlet UIImageView *country_logo;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *discountLab;

@end

NS_ASSUME_NONNULL_END
