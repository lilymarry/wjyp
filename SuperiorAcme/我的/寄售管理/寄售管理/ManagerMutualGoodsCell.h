//
//  ManagerMutualGoodsCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerMutualGoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *merchant_nameLab;
@property (strong, nonatomic) IBOutlet UILabel *order_snLab;
@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;

@property (strong, nonatomic) IBOutlet UILabel *goods_attrLab;
@property (strong, nonatomic) IBOutlet UILabel *shop_priceLab;
@property (strong, nonatomic) IBOutlet UILabel *goods_numLab;

@property (strong, nonatomic) IBOutlet UILabel *max_numLab;
@property (strong, nonatomic) IBOutlet UILabel *cai_numnLab;
@property (strong, nonatomic) IBOutlet UILabel *surplus_numLab;
@property (strong, nonatomic) IBOutlet UIImageView *goods_imagView;

@property (strong, nonatomic) IBOutlet UILabel *already_numLab;
@property (strong, nonatomic) IBOutlet UILabel *indexLab;
@property (strong, nonatomic) IBOutlet UILabel *order_priceLab;
@end

NS_ASSUME_NONNULL_END
