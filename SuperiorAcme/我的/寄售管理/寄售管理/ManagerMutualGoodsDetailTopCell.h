//
//  ManagerMutualGoodsDetailListCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerMutualGoodsDetailTopCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;
@property (strong, nonatomic) IBOutlet UILabel *merchant_nameLab;

@property (strong, nonatomic) IBOutlet UILabel *max_numLab;
@property (strong, nonatomic) IBOutlet UILabel *cai_numnLab;
@property (strong, nonatomic) IBOutlet UILabel *surplus_numLab;


@property (strong, nonatomic) IBOutlet UILabel *already_numLab;

@end

NS_ASSUME_NONNULL_END
