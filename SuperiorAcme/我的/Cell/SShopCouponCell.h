//
//  SShopCouponCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SShopCouponCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;

@property (strong, nonatomic) IBOutlet UIImageView *rigthImageR;
@property (strong, nonatomic) IBOutlet UIImageView *rightImageR_sub;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *source_status;

//特殊显示
@property (strong, nonatomic) IBOutlet UIView *showTimeView;
@property (strong, nonatomic) IBOutlet UIButton *showTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *vou_id;
@property (weak, nonatomic) IBOutlet UILabel *all_money;



@end
