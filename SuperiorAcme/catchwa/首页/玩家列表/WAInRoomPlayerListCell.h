//
//  WAInRoomPlayerListCell.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAInRoomPlayerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;

@property (strong, nonatomic) IBOutlet UIImageView *headImaView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;


@end

NS_ASSUME_NONNULL_END
