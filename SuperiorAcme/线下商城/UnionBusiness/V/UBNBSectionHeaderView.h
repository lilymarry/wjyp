//
//  UBNBSectionHeaderView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBNBSectionHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImgV;

@property (weak, nonatomic) IBOutlet UILabel *pingFenLab;

@property (weak, nonatomic) IBOutlet UILabel *leftTitle;

+(instancetype)instanceWithXIB;

-(void)settingLefetTitle:(NSString *)leftTitle
              rightTitle:(NSString *)rightTitle;

+(CGFloat)viewHeight;

-(void)discribeTextSettingWithText:(NSString *)text
                       replaceText:(NSString *)replaceText;

@end
