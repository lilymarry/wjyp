//
//  SMyShopHeaderView.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SShopManagementModel;

@interface SMyShopHeaderView : UIView

@property (nonatomic, strong) SShopManagementModel * shopManagementModel;

+(instancetype)CreatMyShopHeaderView;

@end
