//
//  WAScrollViewItemView.m
//  imagview+lab横向滚动
//
//  Created by 天津沃天科技 on 2019/1/3.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAScrollViewItemView.h"

@interface WAScrollViewItemView ()

@end

@implementation WAScrollViewItemView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAScrollViewItemView" owner:self options:nil];
        [self addSubview:_thisView];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
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
