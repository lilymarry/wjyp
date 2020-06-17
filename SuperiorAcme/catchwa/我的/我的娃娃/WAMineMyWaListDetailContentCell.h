//
//  MAMineMyWaListDetailContentCell.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TopBtnBlock)(NSInteger type);
@interface WAMineMyWaListDetailContentCell : UITableViewCell

@property (nonatomic, copy) TopBtnBlock topBtnBlock;
@property (weak, nonatomic) IBOutlet UIButton *moneyChangBtn;

@property (weak, nonatomic) IBOutlet UIButton *goodChangBtn;

@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLab;

@property (strong, nonatomic) IBOutlet UILabel *RoomStateLab;
@property (strong, nonatomic) IBOutlet UILabel *roomName;
@property (strong, nonatomic) IBOutlet UILabel *roomNum;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moneyChangBtnWW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *goodChangBtnWW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnWW;





@end

NS_ASSUME_NONNULL_END
