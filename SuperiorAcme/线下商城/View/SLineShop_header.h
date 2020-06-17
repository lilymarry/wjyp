//
//  SLineShop_header.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLineShop_header_selectBtnBlock) ();

@interface SLineShop_header : UIView

@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle_sub;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *addressNum;

@property (nonatomic, copy) SLineShop_header_selectBtnBlock SLineShop_header_selectBtn;
@end
