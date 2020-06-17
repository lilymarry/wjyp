//
//  WAFirstListCell.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//typedef void(^TopBtnBlock)(NSInteger type);

@interface WAFirstListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (weak, nonatomic) IBOutlet UIImageView *ima_headIcon;
//@property (nonatomic, copy) TopBtnBlock topBtnBlock;
@property (weak, nonatomic) IBOutlet UILabel *lab_name;

@property (weak, nonatomic) IBOutlet UILabel *lab_type;

@property (weak, nonatomic) IBOutlet UIButton *ima_focus;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;

@property (strong, nonatomic) IBOutlet UIImageView *ima_yuanbao;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ima_yuanbaoWW;

@property (strong, nonatomic) IBOutlet UIButton *videoBtn;



@end

NS_ASSUME_NONNULL_END
