//
//  WAMoneyListCell.h
//  CatchWAWA
//
//  Created by donkey on 2019/1/5.
//  Copyright © 2019 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAMoneyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (assign, nonatomic) BOOL isChoosed;
@property (strong, nonatomic) IBOutlet UIImageView *head_icon;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;


@end

NS_ASSUME_NONNULL_END
