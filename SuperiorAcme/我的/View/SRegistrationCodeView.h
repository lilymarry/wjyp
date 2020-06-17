//
//  SRegistrationCodeView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SRegistrationCodeViewBackBlock) ();
/*
 *二维码字符串回调
 */
typedef void(^CreatQRCodeStrBlock)(NSString *);

@interface SRegistrationCodeView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (nonatomic, copy) SRegistrationCodeViewBackBlock SRegistrationCodeViewBack;
@property (strong, nonatomic) IBOutlet UIImageView *thisImage;
@property (strong, nonatomic) IBOutlet UIImageView *header_pic;

/*
 *二维码类型
 */
@property (nonatomic, copy) NSString * QRCodeType;

@property (nonatomic, copy) NSString * member_trainer;//会员拜师码
@property (nonatomic, copy) NSString * merchant_trainer;//商户拜师码
@property (nonatomic, copy) NSString * code;//"邀请码",
@property (nonatomic, copy) NSString * stage_merchant_id;//"商家码id",

@property (nonatomic, copy) NSArray * TrainerArr;

@property (nonatomic, copy) CreatQRCodeStrBlock passQRCodeStrBlock;
@end
