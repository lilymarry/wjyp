//
//  WAMineGameListCell.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAMineGameListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_back;

@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UILabel *resultLab;




@end

NS_ASSUME_NONNULL_END
