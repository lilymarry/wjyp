//
//  SMemberOrderView.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SMemberOrderViewInforBlock) (NSString * order_id, NSString * order_status, NSString * member_coding);
typedef void(^SMemberOrderViewOneBtnBlock) (NSString * order_id, NSString * order_status);
typedef void(^SMemberOrderViewTwoBtnBlock) (NSString * order_id, NSString * order_status, UIButton * btn, NSString * member_coding);
typedef void(^SMemberOrderViewOneBtnCommentBlock)(NSString * order_id,UIButton * btn);

/*
 *查看下线商铺订单详情block回调
 */
typedef void(^SOfflineStoreOrderInforBlock) (NSString * order_id, NSString * merchant_id, NSString * pay_status, NSString * status,BOOL common_status);

@interface SMemberOrderView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UITableView *mTable;

- (void)showMolde:(NSArray *)thisArr andType:(NSString *)thisType;
@property (nonatomic, copy) SMemberOrderViewInforBlock SMemberOrderViewInfor;
@property (nonatomic, copy) SMemberOrderViewOneBtnBlock SMemberOrderViewOneBtn;
@property (nonatomic, copy) SMemberOrderViewTwoBtnBlock SMemberOrderViewTwoBtn;
@property (nonatomic, copy) SMemberOrderViewOneBtnCommentBlock sMemberOrderViewOneBtnCommentBlock;

/*
 *查看下线商铺订单详情block回调
 */
@property (nonatomic, copy) SOfflineStoreOrderInforBlock SOfflineStoreOrderInfor;
@end
