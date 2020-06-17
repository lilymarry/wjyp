//
//  SOnlineShop_InfoListView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOnlineShop_InfoListView_selectBlock) (NSString * two_cate_id, NSString * short_name);

@interface SOnlineShop_InfoListView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *groView;
/*
 *拼单购商品列表内,显示参加体验拼单用户的中奖通知信息
 */
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UIView *changeTextView;
@property (weak, nonatomic) IBOutlet UIImageView *noticeTipImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noticeViewToBannerCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noticeViewHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerViewHeightCons;

@property (nonatomic, strong) NSArray * noticeArr;

@property (nonatomic, copy) SOnlineShop_InfoListView_selectBlock SOnlineShop_InfoListView_select;

- (void)showModel:(NSArray *)arr andMyType:(NSString *)myType;
@end
