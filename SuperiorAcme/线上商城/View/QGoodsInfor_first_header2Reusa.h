//
//  QGoodsInfor_first_header2Reusa.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QGoodsInfor_first_header2Reusa : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ticketView_topHHH;
@property (strong, nonatomic) IBOutlet UIView *ticketView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ticketView_HHH;
@property (strong, nonatomic) IBOutlet UIView *ticketView_sub;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ticketView_sub_HHH;

@property (strong, nonatomic) IBOutlet UIView *one_ticketList;
@property (strong, nonatomic) IBOutlet UIButton *one_ticketListBtn;
@property (strong, nonatomic) IBOutlet UIView *two_ticketList;
@property (strong, nonatomic) IBOutlet UIButton *two_ticketListBtn;
@property (strong, nonatomic) IBOutlet UILabel *one_value;
@property (strong, nonatomic) IBOutlet UILabel *one_condition;
@property (strong, nonatomic) IBOutlet UILabel *two_value;
@property (strong, nonatomic) IBOutlet UILabel *two_condition;

@property (strong, nonatomic) IBOutlet UIImageView *goods_server_oneImage;
@property (strong, nonatomic) IBOutlet UILabel *goods_server_oneTitle;
@property (strong, nonatomic) IBOutlet UIImageView *goods_server_twoImage;
@property (strong, nonatomic) IBOutlet UILabel *goods_server_twoTitle;

@property (strong, nonatomic) IBOutlet UIView *InnView;
@property (strong, nonatomic) IBOutlet UILabel *InnTitle;

@property (strong, nonatomic) IBOutlet UIButton *serverBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong, nonatomic) IBOutlet UILabel *send_Content;
@property (strong, nonatomic) IBOutlet UIButton *couponsBtn;

@property (strong, nonatomic) IBOutlet UIImageView *one_ticketListGround;
@property (strong, nonatomic) IBOutlet UIImageView *two_ticketListGround;
@property (weak, nonatomic) IBOutlet UILabel *remarks;

/*
 *更多参团信息
 */
@property (weak, nonatomic) IBOutlet UIButton *MoreActivityButton;
@property (weak, nonatomic) IBOutlet UILabel *seeMoreTipLabel;

@end
