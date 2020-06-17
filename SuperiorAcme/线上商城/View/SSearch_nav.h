//
//  SSearch_nav.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSearch_nav : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *choiceTypeBtn;
@property (strong, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgV;

@property (nonatomic, assign) BOOL isHiddenBtnImgV;

@end
