//
//  WAMine_top.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TopBtnBlock)(NSInteger type);
NS_ASSUME_NONNULL_BEGIN

@interface WAMine_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) TopBtnBlock topBtnBlock;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headImaView;

@property (strong, nonatomic) IBOutlet UILabel *nameLab;



@end

NS_ASSUME_NONNULL_END
