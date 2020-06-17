//
//  WAInRoomNavTopView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAInRoomNavTopView.h"

@interface WAInRoomNavTopView ()


@end

@implementation WAInRoomNavTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAInRoomNavTopView" owner:self options:nil];
        [self addSubview:_thisView];
 
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius =15;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor = [UIColor clearColor].CGColor;
        
        _head1.layer.masksToBounds = YES;
        _head1.layer.cornerRadius = _head1.frame.size.width/2;
       
        _head2.layer.masksToBounds = YES;
        _head2.layer.cornerRadius = _head2.frame.size.width/2;
        
        _head3.layer.masksToBounds = YES;
        _head3.layer.cornerRadius = _head3.frame.size.width/2;
        
        _head4.layer.masksToBounds = YES;
        _head4.layer.cornerRadius = _head4.frame.size.width/2;
      
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
