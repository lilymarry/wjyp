//
//  ManagerMutualGoodsDetailTopCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerMutualGoodsDetailListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goods_imagView;


@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;

@property (strong, nonatomic) IBOutlet UILabel *discountLab;
@property (strong, nonatomic) IBOutlet UILabel *profitLab;
@property (strong, nonatomic) IBOutlet UILabel *consign_sale_numLab;

@property (strong, nonatomic) IBOutlet UILabel *same_sale_numLab;
@property (strong, nonatomic) IBOutlet UILabel *deal_numLab;
@property (strong, nonatomic) IBOutlet UILabel *already_numLab;

@property (strong, nonatomic) IBOutlet UILabel *indexLab;

@property (strong, nonatomic) IBOutlet UIButton *jishouBtn;


@end

NS_ASSUME_NONNULL_END
