//
//  SMyShopHeaderView.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMyShopHeaderView.h"
#import "SShopManagementModel.h"

@interface SMyShopHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewToTopCons;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *payOrderNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imaView_ShopLv;
@property (weak, nonatomic) IBOutlet UILabel *lab_shopLv;


@end

@implementation SMyShopHeaderView

+(instancetype)CreatMyShopHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.containerView.layer.cornerRadius = 13;
//    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.shadowOpacity = 0.7f;
    self.containerView.layer.shadowRadius = 5.0f;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 3);
    self.containerView.layer.shadowColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1].CGColor;
    _containerViewToTopCons.constant *= ScreenW / 414;
}

-(void)setShopManagementModel:(SShopManagementModel *)shopManagementModel{
    _shopManagementModel = shopManagementModel;
    self.payMoneyLabel.text = shopManagementModel.pay_money;
    self.visitNumLabel.text = [NSString stringWithFormat:@"访客量\n%@",shopManagementModel.visit_nums];
    self.payOrderNumLabel.text = [NSString stringWithFormat:@"订单数\n%@",shopManagementModel.pay_orders];
     int i =  [shopManagementModel.set_id intValue];
    switch (i) {
        case 1:
            {
                _imaView_ShopLv.image=[UIImage imageNamed:@"店主等级星星"];
                _lab_shopLv.text=@"初级店主";
            }
            break;
        case 2:
        {
            _imaView_ShopLv.image=[UIImage imageNamed:@"店主等级星星"];
            _lab_shopLv.text=@"中级店主";
        }
            break;
        case 3:
        {
            _imaView_ShopLv.image=[UIImage imageNamed:@"店主等级星星"];
            _lab_shopLv.text=@"高级店主";
        }
            break;
        case 4:
        {
            _imaView_ShopLv.image=[UIImage imageNamed:@"店主等级v"];
            _lab_shopLv.text=@"高级店主+";
        }
            break;
        default:
            break;
    }
    
    
    
}

@end
