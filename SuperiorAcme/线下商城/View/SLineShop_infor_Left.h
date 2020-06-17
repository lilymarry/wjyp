//
//  SLineShop_infor_Left.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLineShop_infor_Left_ScollDelegateBlock) (CGFloat  y);
typedef void(^SLineShop_infor_Left_showRBlock) ();
typedef void(^SLineShop_infor_Left_inforBlock) (NSString * goods_id);

@interface SLineShop_infor_Left : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (nonatomic, copy) SLineShop_infor_Left_ScollDelegateBlock SLineShop_infor_Left_ScollDelegate;
@property (nonatomic, copy) SLineShop_infor_Left_showRBlock SLineShop_infor_Left_showR;
@property (nonatomic, copy) SLineShop_infor_Left_inforBlock SLineShop_infor_Left_infor;
@end
