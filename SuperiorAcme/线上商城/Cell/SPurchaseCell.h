//
//  SPurchaseCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPurchaseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *goods_img;
@property (strong, nonatomic) IBOutlet UILabel *goods_name;
@property (strong, nonatomic) IBOutlet UILabel *shop_price;

@end
