//
//  WAFirstListCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAFirstListCell.h"

@implementation WAFirstListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _view_back.layer.masksToBounds = YES;
    _view_back.layer.cornerRadius = 15;
    _view_back.layer.borderWidth = 0.1;
    _view_back.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    _lab_type.layer.masksToBounds = YES;
    _lab_type.layer.cornerRadius =4;
    _lab_type.layer.borderWidth = 0.1;
    _lab_type.layer.borderColor =[UIColor clearColor].CGColor;
   // [_ima_focus addTarget:self action:@selector(touchDelect) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//-(void)touchDelect
//{
//   self.topBtnBlock(0);
//}


@end
