//
//  UBTypeCell.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBTypeModel.h"

@interface UBTypeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

+(void)xibWithCollectionView:(UICollectionView *)collectionView;
+(NSString *)cellIdentifier;

@end
