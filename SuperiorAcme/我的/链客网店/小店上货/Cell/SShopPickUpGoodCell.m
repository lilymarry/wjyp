//
//  SShopPickUpGoodCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SShopPickUpGoodCell.h"
#import "SShopPickUpModel.h"

@interface SShopPickUpGoodCell ()
@property (weak, nonatomic) IBOutlet UILabel *goodGiveIntegralTipLabel;
/**
 商品的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;

/**
 商品的标题
 */
@property (weak, nonatomic) IBOutlet UILabel *goodTitleLabel;

/**
 商品最多可用的代金券
 */
@property (weak, nonatomic) IBOutlet UILabel *goodAvilableCashCouponLabel;

/**
 商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;

/**
 商品能够赠送的积分
 */
@property (weak, nonatomic) IBOutlet UILabel *goodGiveIntegralLabel;

/**
 上架点击按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *goodOnShelfBtn;
@property (weak, nonatomic) IBOutlet UILabel *cellNumLab;

@end

@implementation SShopPickUpGoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.goodAvilableCashCouponLabel.layer.borderWidth = 1;
    self.goodAvilableCashCouponLabel.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:101.0/255.0 blue:94.0/255.0 alpha:1].CGColor;
    self.goodAvilableCashCouponLabel.layer.cornerRadius = 2;
    self.goodAvilableCashCouponLabel.layer.masksToBounds = YES;
    
    self.goodGiveIntegralTipLabel.layer.cornerRadius = self.goodGiveIntegralTipLabel.bounds.size.width * 0.5;
    self.goodGiveIntegralTipLabel.layer.masksToBounds = YES;
}

-(void)setPickUpModel:(SShopPickUpModel *)pickUpModel{
    _pickUpModel = pickUpModel;
    _goodTitleLabel.text = pickUpModel.goods_name;
    [_goodIconImageView sd_setImageWithURL:[NSURL URLWithString:pickUpModel.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
    _goodAvilableCashCouponLabel.text = [NSString stringWithFormat:@"最多可用%lu%%代金券",pickUpModel.discount.integerValue];
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",pickUpModel.shop_price]];
    [attri addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, pickUpModel.shop_price.length + 1)];
    [attri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, 1)];
    _goodPriceLabel.attributedText = attri;
    
    NSMutableAttributedString * attri1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",pickUpModel.integral]];
    [attri1 addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],NSForegroundColorAttributeName : [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1]} range:NSMakeRange(0, pickUpModel.integral.length + 2)];
    [attri1 addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:253.0/255 green:130.0/255 blue:20.0/255 alpha:1]} range:NSMakeRange(0, pickUpModel.integral.length)];
    _goodGiveIntegralLabel.attributedText = attri1;
    _cellNumLab.text=[NSString stringWithFormat:@"销量:%@件 库存:%@件",pickUpModel.sell_num,pickUpModel.all_goods_num];
    
}

//上架点击事件
- (IBAction)putawayGoodsMethod:(UIButton *)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(putawayGoodsBtnClick:andIndex:)]){
        [_delegate putawayGoodsBtnClick:self andIndex:_index];
    }
}

@end
