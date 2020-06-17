//
//  WADailySginIn1.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WADailySginIn1.h"
#import "WADailySginInCell.h"
#import "Luck.h"
@interface WADailySginIn1 ()<CAAnimationDelegate,LuckDelegate>
{
    NSMutableArray *arr;
}
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation WADailySginIn1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WADailySginIn1" owner:self options:nil];
        [self addSubview:_thisView];
    }
    return self;
}
-(void)getData:(NSArray *)data
{
    arr=[NSMutableArray arrayWithArray:data];
    Luck *luck = [[Luck alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW)];
    luck.imageArray =  [arr mutableCopy];
   
    // 基础循环次数
    luck.circleNum = 3;
    luck.delegate = self;
    [self.backView addSubview: luck];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (void)luckViewDidStopWithArrayCount:(NSInteger)count is_Repeat:(BOOL)is_Repeat{
    self.priceBtnBlock(count,is_Repeat);
}
- (IBAction)btnPress:(id)sender {
    [self removeFromSuperview];
}




@end
