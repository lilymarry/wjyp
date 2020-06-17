//
//  SRecommendVersionOneCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/5/4.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SRecommendVersionOneCell.h"
#import "SUserMyRecommend.h"
#import "SRecommendCellBottomView.h"
#define scale ScreenW/414

typedef NS_ENUM(NSInteger, VipType) {
    kVipTypeWuJie = 1,
    kVipTypeWuYou,
    kVipTypeYouXiang
};


@interface SRecommendVersionOneCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *recomendCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet SRecommendCellBottomView *WuJieView;
@property (weak, nonatomic) IBOutlet SRecommendCellBottomView *WuYouView;
@property (weak, nonatomic) IBOutlet SRecommendCellBottomView *YouXiangView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewWidthCons;

@end

@implementation SRecommendVersionOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _containerView.layer.cornerRadius = 5;
    _vipLabel.layer.cornerRadius = 8;
    _vipLabel.layer.borderWidth = 1;
    _vipLabel.layer.borderColor = [UIColor colorWithRed:255.0/255 green:38.0/255 blue:0.0/255 alpha:1.0].CGColor;
    _iconImageViewWidthCons.constant *= scale;
    _iconImageVIew.layer.cornerRadius = _iconImageViewWidthCons.constant * 0.5;
    _iconImageVIew.layer.masksToBounds = YES;
}

#pragma mark - 根据模型数据设置子控件的内容
-(void)setUserRecommend:(SUserMyRecommend *)userRecommend{
    _userRecommend = userRecommend;
    [_iconImageVIew sd_setImageWithURL:[NSURL URLWithString:userRecommend.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    
    _nickNameLabel.text = userRecommend.nickname;
    _phoneLabel.text = userRecommend.phone;
    _timeLabel.text = [NSString stringWithFormat:@"%@",userRecommend.time];
    _recomendCountLabel.text = [NSString stringWithFormat:@"%@人",userRecommend.num];
    _IDLabel.text = [NSString stringWithFormat:@"ID：%@",userRecommend.id];
    
    //设置会员状态
    switch (userRecommend.member_coding.integerValue) {
        case kVipTypeWuJie:
            _vipLabel.text = @"无界会员";
            break;
        case kVipTypeWuYou:
            _vipLabel.text = @"无忧会员";
            break;
        case kVipTypeYouXiang:
            _vipLabel.text = @"优享会员";
            break;
        default:
            break;
    }
    
    _WuJieView.titleString = @"无界";
    _WuJieView.umbrellaString = userRecommend.umbrella_coding_one;
    _WuJieView.codingString = userRecommend.coding_one;
    
    _WuYouView.titleString = @"无忧";
    _WuYouView.umbrellaString = userRecommend.umbrella_coding_two;
    _WuYouView.codingString = userRecommend.coding_two;
    
    _YouXiangView.titleString = @"优享";
    _YouXiangView.umbrellaString = userRecommend.umbrella_coding_three;
    _YouXiangView.codingString = userRecommend.coding_three;
}

@end
