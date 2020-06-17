//
//  SLotInfor_submit.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/3.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLotInfor_submit_backBlock) ();
typedef void(^SLotInfor_submit_payMoneyBlock) (NSString * payMoney);

@interface SLotInfor_submit : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UITextField *payMoney_TF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *down_HHH;

@property (nonatomic, copy) SLotInfor_submit_backBlock SLotInfor_submit_back;
@property (nonatomic, copy) SLotInfor_submit_payMoneyBlock SLotInfor_submit_payMoney;
@end
