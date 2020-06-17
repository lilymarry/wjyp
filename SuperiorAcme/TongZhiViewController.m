//
//  TongZhiViewController.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/15.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "TongZhiViewController.h"
#import "SNTabBarController.h"
@interface TongZhiViewController ()

@end

@implementation TongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _text.text=_jsonStr;
}
- (IBAction)dsdsad:(id)sender {
    SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
    self.view.window.rootViewController = tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
