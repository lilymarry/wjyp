//
//  SOnlineShopInfor_ClassView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOnlineShopInfor_ClassView_BackBlock) ();
typedef void(^SOnlineShopInfor_ClassView_ChoiceBlock) (NSString * typeName, NSInteger index);

@interface SOnlineShopInfor_ClassView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mCollect_HHH;

@property (nonatomic, copy) SOnlineShopInfor_ClassView_BackBlock SOnlineShopInfor_ClassView_Back;
@property (nonatomic, copy) SOnlineShopInfor_ClassView_ChoiceBlock SOnlineShopInfor_ClassView_Choice;
@end
