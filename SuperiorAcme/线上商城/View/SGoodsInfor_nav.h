//
//  SGoodsInfor_nav.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGoodsInfor_nav : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FourBtn;
@property (weak, nonatomic) IBOutlet UIView *FourLine;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoBtn_WWW;

@property (strong, nonatomic) IBOutlet UIView *oneLine;
@property (strong, nonatomic) IBOutlet UIView *twoLine;
@property (strong, nonatomic) IBOutlet UIView *threeLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoBtnCenterConstant;

//判断是否是足迹或者收藏  默认否
@property (nonatomic, assign) BOOL isCollectOrFooter;

@end
