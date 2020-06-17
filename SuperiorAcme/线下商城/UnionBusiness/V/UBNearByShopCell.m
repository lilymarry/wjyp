//
//  UBNearByShopCell.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBNearByShopCell.h"
#import "SOffLineNearbyStoreListModel.h"
#import <Masonry.h>

@interface UBNearByShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;//店铺icon
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;//店铺标题
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;//店铺距离我多远
@property (weak, nonatomic) IBOutlet UILabel *monthOrderLabel;//月售
@property (weak, nonatomic) IBOutlet UILabel *shopDesLabel;//店铺描述
@property (weak, nonatomic) IBOutlet UIView *starView;//评价星星
@property (weak, nonatomic) IBOutlet UILabel *transportTimeLabel;//配送
@property (weak, nonatomic) IBOutlet UILabel *separatorLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *vLineLab;




@end

@implementation UBNearByShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shopIconImageView.layer.borderColor = [UIColor clearColor].CGColor;
    self.shopIconImageView.layer.borderWidth = 1.0f;
    self.shopIconImageView.layer.cornerRadius = 5;
    self.shopIconImageView.clipsToBounds = YES;
}

-(void)setNearByStoreModel:(SOffLineNearbyStoreListModel *)nearByStoreModel{
    _nearByStoreModel = nearByStoreModel;
    [self.shopIconImageView sd_setImageWithURL:[NSURL URLWithString:nearByStoreModel.logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    self.shopTitleLabel.text = nearByStoreModel.merchant_name;
    self.monthOrderLabel.text = [NSString stringWithFormat:@"月售%@单",nearByStoreModel.months_order];
    self.shopDesLabel.text = nearByStoreModel.merchant_desc;
    
    //展示距离
    if ([nearByStoreModel.distance isEqualToString:@"-1"]) {
        self.distanceLabel.text = @"";
    }else{
        self.distanceLabel.text = [NSString stringWithFormat:@"距您%@km",nearByStoreModel.distance];
        self.distanceLabel.adjustsFontSizeToFitWidth=YES;
     
    }
    
    if (_nearByStoreModel.isSearch) {
        self.distanceLabel.text = @"进店逛逛";
        self.distanceLabel.layer.borderColor = [UIColor redColor].CGColor;
        self.distanceLabel.layer.borderWidth = 1.0f;
        self.distanceLabel.layer.cornerRadius = 10;
        self.distanceLabel.clipsToBounds = YES;
        self.distanceLabel.textAlignment = 1;
        self.distanceLabel.textColor = [UIColor redColor];
        [self.distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.shopTitleLabel);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(70, 20));
        }];
    }

    //设置评价星星
    CGFloat score = nearByStoreModel.score.floatValue;
    CGFloat pointScore = (int)(score * 10) % 10;
    NSUInteger integerScore = (int)(score * 10) / 10;
    for (int i = 0; i < integerScore; i++) {
        UIImageView * imageView = self.starView.subviews[i];
        imageView.image = [UIImage imageNamed:@"评价黄星"];
    }
    if (0 != pointScore) {
        UIImageView * imageView = self.starView.subviews[integerScore + 1];
        imageView.image = [UIImage imageNamed:@""];//半星
    }
//    _nearByStoreModel.user_id  瞎J8改
    self.monthOrderLabel.hidden = !_nearByStoreModel.user_id;
   
    if ([_nearByStoreModel.months_order intValue]==0) {
        self.monthOrderLabel.hidden = YES;
    }
    else
    {
         self.monthOrderLabel.hidden = NO;
    }
     self.vLineLab.hidden = self.monthOrderLabel.hidden;
    
}

+(void)xibWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:[UBNearByShopCell cellIdentifer] bundle:nil]
    forCellReuseIdentifier:[UBNearByShopCell cellIdentifer]];
}

+(NSString *)cellIdentifer{
    return NSStringFromClass([self class]);
}

@end
