//
//  CommonMoreView.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//  更多视图
typedef void(^MoreBtnBlock)(UIViewController * vc);
typedef void(^CloseMoreView)();

#import <UIKit/UIKit.h>
#import "STicketFight.h"
#import "SWelfareAgency.h"
#import "SListedIncubation.h"
#import "SCarShop.h"

@interface CommonMoreView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (nonatomic, copy) MoreBtnBlock moreBtnBlock;
@property (nonatomic, copy) CloseMoreView closeMoreView;

@end
