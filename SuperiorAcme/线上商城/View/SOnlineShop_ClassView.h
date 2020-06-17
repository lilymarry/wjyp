//
//  SOnlineShop_ClassView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOnlineShop_ClassView_choiceTypeBlock) (NSInteger indexPath, NSString * cate_id);
typedef void(^SOnlineShop_ClassView_PushBlock) ();

@interface SOnlineShop_ClassView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *this_HHH;

//推荐、食品
@property (nonatomic, copy) SOnlineShop_ClassView_choiceTypeBlock SOnlineShop_ClassView_choiceType;
//其他类型
@property (nonatomic, copy) SOnlineShop_ClassView_PushBlock SOnlineShop_ClassView_Push;

- (void)showModel:(NSArray *)arr;
@end
