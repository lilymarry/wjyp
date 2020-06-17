//
//  SCoupons_OPEN.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SCoupons_OPEN_BackBlock) ();

@interface SCoupons_OPEN : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

@property (nonatomic, copy) SCoupons_OPEN_BackBlock SCoupons_OPEN_Back;

- (void)showModel:(NSArray *)arr andType:(NSString *)type;
@end
