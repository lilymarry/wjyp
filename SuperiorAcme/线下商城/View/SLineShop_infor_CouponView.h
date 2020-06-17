//
//  SLineShop_infor_CouponView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLineShop_infor_CouponView_BackBlock) ();
typedef void(^SLineShop_infor_CouponView_getBlock) (NSString * ticket_id);

@interface SLineShop_infor_CouponView : UIView
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;

@property (nonatomic, copy) SLineShop_infor_CouponView_BackBlock SLineShop_infor_CouponView_Back;
@property (nonatomic, copy) SLineShop_infor_CouponView_getBlock SLineShop_infor_CouponView_get;

- (void)showNotice:(NSString *)announce;
- (void)showModel:(NSArray *)arr;
@end
