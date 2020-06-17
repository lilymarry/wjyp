//
//  WACatchListCell.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//typedef void(^TopBtnBlock)(NSInteger type);
@interface WACatchListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_back;
//@property (nonatomic, copy) TopBtnBlock topBtnBlock;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headImaview;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;






@end

NS_ASSUME_NONNULL_END
