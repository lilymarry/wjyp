//
//  CleanMutualStateCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface InCleanMutualStateCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *goods_imagView;
@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;
@property (strong, nonatomic) IBOutlet UILabel *profitLab;
@property (strong, nonatomic) IBOutlet UILabel *pay_timeLab;
@property (strong, nonatomic) IBOutlet PopButton *operationBtn;

@end

NS_ASSUME_NONNULL_END
