//
//  OsManagerNewsView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManagerNewsView.h"

@interface OsManagerNewsView ()

@end

@implementation OsManagerNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"OsManagerNewsView" owner:self options:nil];
        [self addSubview:_thisView];
        
        
           UITapGestureRecognizer * longPressGest= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        
            [_thisView addGestureRecognizer:longPressGest];
     
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
-(void)tapView
{
    [self removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
