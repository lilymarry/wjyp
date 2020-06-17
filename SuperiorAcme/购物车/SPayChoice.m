//
//  SPayChoice.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPayChoice.h"

@interface SPayChoice ()

@property (strong, nonatomic) IBOutlet UIView *groundView;

@end

@implementation SPayChoice

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
    [_groundView setFrame:CGRectMake(0, 133, 250, 100)];
}
- (IBAction)redBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SPayChoice_choice) {
            self.SPayChoice_choice(0);
        }
    }];
}
- (IBAction)yellowBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SPayChoice_choice) {
            self.SPayChoice_choice(1);
        }
    }];
}
- (IBAction)blueBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SPayChoice_choice) {
            self.SPayChoice_choice(2);
        }
    }];
}

- (IBAction)notBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //单商品
        if ([sender.titleLabel.text isEqualToString:@"不使用"]) {
            if (self.SPayChoice_choice) {
                self.SPayChoice_choice(3);
            }
        }
    }];
}
- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
