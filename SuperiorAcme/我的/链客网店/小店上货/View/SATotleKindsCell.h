//
//  SATotleKindsCell.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MicroToolHeader.h"
#import "SShopPickUpModel.h"

@interface SATotleKindsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

/**
 上架商品的模型
 */
@property (nonatomic, strong) SShopPickUpModel * pickUpModel;

@end
