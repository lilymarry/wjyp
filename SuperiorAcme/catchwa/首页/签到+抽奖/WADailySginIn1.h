//
//  WADailySginIn1.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PriceBtnBlock)(NSInteger type, BOOL is_Repeat);
@interface WADailySginIn1 : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (nonatomic, copy) PriceBtnBlock priceBtnBlock;
-(void)getData:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
