//
//  SOnlineShop_ClassInfoList_more_footerCont.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOnlineShop_ClassInfoList_more_footerCont_selectBlock) (NSString * goods_id);

@interface SOnlineShop_ClassInfoList_more_footerCont : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mCollect_HHH;

@property (nonatomic, copy) SOnlineShop_ClassInfoList_more_footerCont_selectBlock SOnlineShop_ClassInfoList_more_footerCont_select;

- (void)showModel:(NSArray *)arr andPriceShow:(BOOL)show_isno andType:(NSString *)model_type;
@end
