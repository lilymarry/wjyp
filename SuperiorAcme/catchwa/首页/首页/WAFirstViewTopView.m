//
//  WAFirstViewTopView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAFirstViewTopView.h"
#import "GetRoomListModel.h"
#import "WAInRoomTopViewCell1.h"
#import "WAfirstItemListView.h"
@interface WAFirstViewTopView ()
{
    NSArray *data;
}
@end

@implementation WAFirstViewTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAFirstViewTopView" owner:self options:nil];
        [self addSubview:_thisView];
        _bannerView.layer.masksToBounds = YES;
        _bannerView.layer.cornerRadius = 15;
        _bannerView.layer.borderWidth = 5;
        _bannerView.layer.borderColor =[UIColor clearColor].CGColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)getData:(NSArray *)arr
{
  
    data=arr;
    for (WAInRoomTopViewCell1 *TopView in _scrollView.subviews) {
        [TopView removeFromSuperview];
    }
    
    CGFloat  viewWidth =101;
    CGFloat  viewHeight =74;
    for (int i = 0 ; i<arr.count ; i ++) {
        GetRoomListModel *model=arr[i];
        
        WAInRoomTopViewCell1 *TopView = [[WAInRoomTopViewCell1 alloc] initWithFrame:CGRectMake((viewWidth)*i, 0, viewWidth, viewHeight)];
        TopView.layer.masksToBounds = YES;
        TopView.layer.cornerRadius = TopView.frame.size.width/2;
        TopView.layer.borderWidth = 0.1;
        TopView.layer.borderColor =[UIColor clearColor].CGColor;
        TopView.userInteractionEnabled=YES;
        
        
        
        [TopView .headerImage sd_setImageWithURL:[NSURL URLWithString:model.pic]
                              placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
        TopView.contentLab.text=model.name;
     
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:TopView.bounds];
        bt.tag = i;
        [bt addTarget:self action:@selector(whenClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [TopView addSubview:bt];
        
        [_scrollView addSubview:TopView];
    }
    _scrollView.contentSize = CGSizeMake(arr.count*viewWidth+20, 0);

}
-(void)whenClick:(id)sender
{
    UIButton *but=(UIButton *)sender;
     GetRoomListModel *model=data[but.tag];
    UIViewController *vc=[self viewController];
    WAfirstItemListView *wa=[[WAfirstItemListView alloc]init];
    wa.clumn=model.clumn;
    wa.status=model.status;
    wa.title=model.name;
    wa.hidesBottomBarWhenPushed=YES;
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
