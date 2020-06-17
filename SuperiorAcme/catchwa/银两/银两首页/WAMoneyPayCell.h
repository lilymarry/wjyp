//
//  WAMoneyPayCell.h
//  CatchWAWA
//
//  Created by donkey on 2019/1/5.
//  Copyright © 2019 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAMoneyPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ima_pay;
@property (weak, nonatomic) IBOutlet UILabel *lab_payName;
@property (weak, nonatomic) IBOutlet UIImageView *ima_state;
@property (weak, nonatomic) IBOutlet UIView *view_back;

//@property ( nonatomic) BOOL isChoosed;

@end

NS_ASSUME_NONNULL_END
