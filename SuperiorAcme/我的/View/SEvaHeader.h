//
//  SEvaHeader.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEvaHeader : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *nick;
@property (strong, nonatomic) IBOutlet UILabel *goods_type;
@property (strong, nonatomic) IBOutlet UILabel *evaContent;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *evaContent_HHH;

- (void)showModel:(NSArray *)arr;
@end
