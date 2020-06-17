//
//  SLimited_NewContent.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLimited_NewContent_inforBlock) (NSString * goods_id);
typedef void(^SLimited_NewContent_showModelBlock) ();
typedef void(^SLimited_NewContent_setBlock) (NSString * limit_buy_id);
typedef void(^SLimited_NewContent_bannerViewBlock) ();

@interface SLimited_NewContent : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

@property (nonatomic, copy) SLimited_NewContent_inforBlock SLimited_NewContent_infor;

- (void)thisType:(NSString *)type;
- (void)showModel:(NSArray * )arr andBanner:(NSArray *)bannerArr andContent:(NSString *)content;
@property (nonatomic, copy) SLimited_NewContent_showModelBlock SLimited_NewContent_showModel;
@property (nonatomic, copy) SLimited_NewContent_setBlock SLimited_NewContent_set;
@property (nonatomic, copy) SLimited_NewContent_bannerViewBlock SLimited_NewContent_bannerView;
@end
