//
//  WAInRoomTopViewCell1.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAInRoomTopViewCell1.h"

@interface WAInRoomTopViewCell1 ()

@end

@implementation WAInRoomTopViewCell1
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAInRoomTopViewCell1" owner:self options:nil];
        [self addSubview:_thisView];
        
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
        _headerImage.layer.borderWidth = 0.5;
        _headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        
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
