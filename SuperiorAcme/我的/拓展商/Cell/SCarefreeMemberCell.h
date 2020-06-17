//
//  SCarefreeMemberCell.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGoodsGoodsList.h"

@interface SCarefreeMemberCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *thisTime;

@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;

-(void)fullDataWithModel:(SGoodsGoodsList *)model;

@end
