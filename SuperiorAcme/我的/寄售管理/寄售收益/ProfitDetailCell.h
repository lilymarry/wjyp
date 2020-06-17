//
//  ProfitDetailCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/9.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ima_grade;

@property (weak, nonatomic) IBOutlet UIImageView *ima_head;

@property (weak, nonatomic) IBOutlet UILabel *lab_name;
@property (weak, nonatomic) IBOutlet UILabel *lab_price;
@property (weak, nonatomic) IBOutlet UILabel *lab_rank;
@end

NS_ASSUME_NONNULL_END
