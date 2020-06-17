//
//  SOrderConfirm_goodsCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderConfirm_goodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *goods_img;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *shop_price;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *goods_attr;
@property (weak, nonatomic) IBOutlet UIView *view_2980;
@property (weak, nonatomic) IBOutlet UILabel *lab_2980;
@end
