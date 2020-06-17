//
//  QGoodsInfor_first_header3_evaCollect.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QGoodsInfor_first_header3_evaCollect : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

- (void)showModel:(NSArray *)arr andType:(NSString *)type;
@end
