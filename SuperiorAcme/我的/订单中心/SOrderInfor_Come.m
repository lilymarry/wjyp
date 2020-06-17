//
//  SOrderInfor_Come.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderInfor_Come.h"

@interface SOrderInfor_Come ()

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;
@end

@implementation SOrderInfor_Come

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 5;
    
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.cornerRadius = 3;
    
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.layer.cornerRadius = 3;
}

- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)oneBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SOrderInfor_Come_choice) {
            self.SOrderInfor_Come_choice(@"2");
        }
    }];
}
- (IBAction)twoBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.SOrderInfor_Come_choice) {
            self.SOrderInfor_Come_choice(@"1");
        }
    }];
}
- (IBAction)choiceBtn:(UIButton *)sender {
//    sender.selected = !sender.selected;
}

@end
