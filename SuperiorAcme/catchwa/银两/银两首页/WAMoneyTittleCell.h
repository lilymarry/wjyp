//
//  WAMoneyTittleCell.h
//  CatchWAWA
//
//  Created by donkey on 2019/1/5.
//  Copyright © 2019 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^WAMoneyTittleCellBtnBlock)(void);
@interface WAMoneyTittleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imaV_back;
@property (nonatomic, copy) WAMoneyTittleCellBtnBlock wAMoneyTittleCellBtnBlock;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;


@end

NS_ASSUME_NONNULL_END
