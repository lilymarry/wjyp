//
//  Luck.h
//  抽奖
//  fan

//  Created by 亿缘 on 2017/7/15.
//  Copyright © 2017年 亿缘. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LuckDelegate <NSObject>
@optional
- (void)luckViewDidStopWithArrayCount:(NSInteger)count is_Repeat:(BOOL)is_Repeat;
- (void)luckSelectBtn:(UIButton *)btn;

@end

@interface Luck: UIView


@property (assign, nonatomic) id<LuckDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *imageArray; // 奖品数组
@property (nonatomic, assign)int circleNum;

@end
