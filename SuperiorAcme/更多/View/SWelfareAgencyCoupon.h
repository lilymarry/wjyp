//
//  SWelfareAgencyCoupon.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SWelfareAgencyCoupon_ShowModelAgainBlock) ();
typedef void(^SWelfareAgencyCoupon_getBlock) (NSString * ticket_id);

@interface SWelfareAgencyCoupon : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UITableView *mTable;

- (void)showModel:(NSArray *)arr;
@property (nonatomic, copy) SWelfareAgencyCoupon_ShowModelAgainBlock SWelfareAgencyCoupon_ShowModelAgain;
@property (nonatomic, copy) SWelfareAgencyCoupon_getBlock SWelfareAgencyCoupon_get;
@end
