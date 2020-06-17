//
//  SGoodsExplainCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/15.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGoodsExplainCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thisImage;
@property (strong, nonatomic) IBOutlet UILabel *thisContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageVIewWidthCons;

/*
 *添加分割线
 */
@property (weak, nonatomic) IBOutlet UIImageView *separatorLine;

@end
