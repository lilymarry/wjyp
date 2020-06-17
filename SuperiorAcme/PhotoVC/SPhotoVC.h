//
//  SPhotoVC.h
//  ShoesCloud
//
//  Created by TXD_air on 15/12/14.
//  Copyright © 2015年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SPhotoVCBlock) ();
typedef void(^SPhotoVC_ChoicekBlock) ();
typedef void(^SPhotoVC_PhotoBlock) ();
@interface SPhotoVC : UIViewController
@property (nonatomic, copy) SPhotoVCBlock SPhotoVC;
@property (nonatomic, copy) SPhotoVC_ChoicekBlock SPhotoVC_Choicek;
@property (nonatomic, copy) SPhotoVC_PhotoBlock SPhotoVC_Photo;

@property (nonatomic, copy) NSString * gender;//性别

@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;
@property (strong, nonatomic) IBOutlet UIButton *photoBtn;
@end
