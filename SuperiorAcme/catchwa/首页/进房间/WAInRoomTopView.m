//
//  WAInRoomTopView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/11.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAInRoomTopView.h"
#import "WAInRoomTopViewCell1.h"
#import "WAMineMyWaList.h"
#import "ELPCircleConsoleView.h"
#import "RoomDataModel.h"
@interface WAInRoomTopView ()<ELPCircleConsoleMoveDelegate>
{
    NSMutableArray *dataArr;
}
@end

@implementation WAInRoomTopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAInRoomTopView" owner:self options:nil];
        [self addSubview:_thisView];
        
        ELPCircleConsoleView *gradleView = [[ELPCircleConsoleView alloc]init];
        gradleView.delegate = self;
        gradleView.frame = CGRectMake(0, 0, _handelView.frame.size.width, _handelView.frame.size.height);
        [_handelView addSubview:gradleView];
        
    }
    return self;
}
-(void)getData:(NSArray *)data;
{
    dataArr =[NSMutableArray arrayWithArray:data];
   
    for (WAInRoomTopViewCell1 *TopView in _scrollView.subviews) {
        [TopView removeFromSuperview];
    }
    
    CGFloat  viewWidth =101;
    CGFloat  viewHeight =74;
    for (int i = 0 ; i < dataArr.count; i ++) {
        RoomDataModel *model=dataArr[i];
        WAInRoomTopViewCell1 *TopView = [[WAInRoomTopViewCell1 alloc] initWithFrame:CGRectMake((viewWidth)*i, 0, viewWidth, viewHeight)];
        TopView.layer.masksToBounds = YES;
        TopView.layer.cornerRadius = TopView.frame.size.width/2;
        TopView.layer.borderWidth = 0.1;
        TopView.layer.borderColor =[UIColor clearColor].CGColor;
        TopView.userInteractionEnabled=YES;
        TopView.contentLab.text=[NSString stringWithFormat:@"抓中%@次",model.num];
        [TopView.headerImage sd_setImageWithURL:[NSURL URLWithString:model.head_pic]
                              placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:TopView.bounds];
        bt.tag = i;
        [bt addTarget:self action:@selector(whenClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [TopView addSubview:bt];
        
        [_scrollView addSubview:TopView];
    }
     _scrollView.contentSize = CGSizeMake(dataArr.count*viewWidth, 0);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)rotateCircleView:(ELPCircleConsoleView *)rotetaCircleView didRotateWithValueX:(NSString *)Xstr valueY:(NSString *)Ystr stop:(BOOL)needStop moveDirection:(ELPCircleConsoleMoveDirection)orientation{
    
    //TODO for your own action method
    if(orientation == ELPCircleConsoleMoveDirectionUp){
        NSLog(@"rotate to up");
        self.tapOrientaBlock(1);
    }
    else if(orientation == ELPCircleConsoleMoveDirectionDown){
        NSLog(@"rotate to down");
        self.tapOrientaBlock(0);
    }
    else if(orientation == ELPCircleConsoleMoveDirectionLeft){
        NSLog(@"rotate to left");
        self.tapOrientaBlock(2);
    }
    else if(orientation == ELPCircleConsoleMoveDirectionRight){
        NSLog(@"rotate to right");
        self.tapOrientaBlock(3);
    }
    else if(orientation == ELPCircleConsoleMoveDirectionUpStop){
        NSLog(@"stop the priori direction method and turn to up");
    }
    else if(orientation == ELPCircleConsoleMoveDirectionDownStop){
        NSLog(@"stop the priori direction method and turn to down");
    }
    else if(orientation == ELPCircleConsoleMoveDirectionLeftStop){
        NSLog(@"stop the priori direction method and turn to left");
    }
    else if(orientation == ELPCircleConsoleMoveDirectionRightStop){
        NSLog(@"stop the priori direction method and turn to right");
    }
    else if(orientation ==  ELPCircleConsoleMoveDirectionStop)
           {
               NSLog(@"回到中心");
                self.tapOrientaBlock(5);
           }
}

#pragma  mark 我的娃娃
-(void)whenClick:(id)sender
{
   
    UIButton *but=(UIButton *)sender;
    RoomDataModel *model=dataArr[but.tag];
    UIViewController *vc=[self viewController];
        WAMineMyWaList *wa=[[WAMineMyWaList alloc]init];
    wa.isUser=YES;
    wa.user_id=model.user_id;
    [vc.navigationController pushViewController:wa animated:YES];
    
}
- (UIViewController *)viewController

{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
}

@end
