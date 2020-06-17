//
//  SEB_VoucherAuditView.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SEB_VoucherAuditView_InforBlock) ();
typedef void(^SEB_VoucherAuditView_oneBtnBlock) (UIButton * btn);
typedef void(^SEB_VoucherAuditView_twoBtnBlock) (UIButton * btn);

@interface SEB_VoucherAuditView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@property (nonatomic, copy) SEB_VoucherAuditView_InforBlock SEB_VoucherAuditView_Infor;
@property (nonatomic, copy) SEB_VoucherAuditView_oneBtnBlock SEB_VoucherAuditView_oneBtn;
@property (nonatomic, copy) SEB_VoucherAuditView_twoBtnBlock SEB_VoucherAuditView_twoBtn;;


- (void)showModel:(NSString *)type;//模拟不同类型状态
- (void)showModel_sub:(BOOL)isno;//中间有几条，默认3条
@end
