//
//  SOrderCenter_listView_footer.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderCenter_listView_footer : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UILabel *thisType;
@property (strong, nonatomic) IBOutlet UIProgressView *thisPro;
@property (strong, nonatomic) IBOutlet UILabel *thisPro_num;
@property (strong, nonatomic) IBOutlet UILabel *thisPro_title;

@property (strong, nonatomic) IBOutlet UILabel *thisContent;
@property (strong, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topView_HHH;
@end
