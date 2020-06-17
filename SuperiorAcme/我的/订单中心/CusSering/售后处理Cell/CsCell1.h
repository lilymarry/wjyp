//
//  CsCell1.h
//  TaoMiShop
//
//  Created by TXD_air on 16/10/22.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CsCell1 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thisTitle_HHH;
@property (weak, nonatomic) IBOutlet UIView *thisTitleLine;
@property (weak, nonatomic) IBOutlet UILabel *thisContent;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end
