//
//  SLineShop_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBTypeCell.h"

typedef void(^UBShopTypeEntryBlock)(UBTypeModel *typeModel);

@interface SLineShop_top : UIView <UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerTopImage;
@property (strong, nonatomic) IBOutlet UIView *barnnerView;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UILabel *oneTitle;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UILabel *twoTitle;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UILabel *threeTitle;

@property (weak, nonatomic) IBOutlet UIButton *sec_oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *sec_twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *sec_threeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sec_oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *sec_twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *sec_threeImage;

@property (weak, nonatomic) IBOutlet UIImageView *ads_Image;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (weak, nonatomic) IBOutlet UIView *collectionTypeView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy) UBShopTypeEntryBlock typyEntryBlcok;

@end
