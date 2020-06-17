//
//  SEV_window.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEV_window.h"

@interface SEV_window ()

@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;

@end

@implementation SEV_window

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
    _oneView.layer.masksToBounds = YES;
    _oneView.layer.cornerRadius = 3;
    _oneView.layer.borderWidth = 0.5;
    _oneView.layer.borderColor = WordColor_sub_sub_sub.CGColor;
    _twoView.layer.masksToBounds = YES;
    _twoView.layer.cornerRadius = 3;
    _twoView.layer.borderWidth = 0.5;
    _twoView.layer.borderColor = WordColor_sub_sub_sub.CGColor;
}
- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)submitBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
