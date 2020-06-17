//
//  SPhotoVC.m
//  ShoesCloud
//
//  Created by TXD_air on 15/12/14.
//  Copyright © 2015年 GYM. All rights reserved.
//

#import "SPhotoVC.h"

@interface SPhotoVC ()
@property (strong, nonatomic) IBOutlet UIButton *backGroundBack;

@property (strong, nonatomic) IBOutlet UIButton *cancel;

@property (strong, nonatomic) IBOutlet UIView *topView;
@end

@implementation SPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showUI];
}

- (void)showUI
{
    if ([_gender isEqualToString:@"性别"]) {
        [_photoBtn setTitle:@"男" forState:UIControlStateNormal];
        [_choiceBtn setTitle:@"女" forState:UIControlStateNormal];
    } else {
        [_photoBtn setTitle:@"拍照" forState:UIControlStateNormal];
        [_choiceBtn setTitle:@"从相册选择" forState:UIControlStateNormal];
    }
    [_backGroundBack addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    _cancel.layer.masksToBounds = YES;
//    _cancel.layer.cornerRadius = 5.0;
    [_cancel addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _cancel.layer.masksToBounds = YES;
    _cancel.layer.cornerRadius = 5;
    
//    _choiceBtn.layer.masksToBounds = YES;
//    _choiceBtn.layer.cornerRadius = 5.0;
    [_choiceBtn addTarget:self action:@selector(choiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    _photoBtn.layer.masksToBounds = YES;
//    _photoBtn.layer.cornerRadius = 5.0;
    [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _topView.layer.masksToBounds = YES;
    _topView.layer.cornerRadius = 5;
}

- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.SPhotoVC) {
        self.SPhotoVC();
    }
}

- (void)choiceBtnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SPhotoVC_Choicek) {
            self.SPhotoVC_Choicek();
        }
    }];
}

- (void)photoBtnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SPhotoVC_Photo) {
            self.SPhotoVC_Photo();
        }
    }];
}
@end
