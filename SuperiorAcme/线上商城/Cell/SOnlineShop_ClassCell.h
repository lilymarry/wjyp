//
//  SOnlineShop_ClassCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOnlineShop_ClassCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thisImage;
@property (strong, nonatomic) IBOutlet UILabel *thisContent;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thisImageHHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thisImage_leftWWW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thisImage_rightWWW;
@end
