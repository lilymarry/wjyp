//
//  ManifestInformationVC.h
//  TaoMiShop
//
//  Created by zhaobaofeng on 16/8/9.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOrderInfor.h"

@interface ManifestInformationVC : UIViewController
@property (nonatomic, copy) NSString * back_apply_id;//售后ID
@property (nonatomic, strong) SOrderInfor * infor_back;

@end
