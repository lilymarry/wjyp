//
//  WAMineMyWaListCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/16.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAMineMyWaListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *roomId;
@property (strong, nonatomic) IBOutlet UIImageView *headIma;
@property (strong, nonatomic) IBOutlet UILabel *goods_nameLab;
@property (strong, nonatomic) IBOutlet UILabel *num_lab;
@property (strong, nonatomic) IBOutlet UILabel *roomNameLab;
@property (strong, nonatomic) IBOutlet UILabel *changeNumLab;
@property (strong, nonatomic) NSString *start_time;
/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;
/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)();
@end

NS_ASSUME_NONNULL_END
