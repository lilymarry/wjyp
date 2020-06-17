//
//  WARoomCatchSuccessView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WARoomCatchSuccessView.h"

@interface WARoomCatchSuccessView ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@end

@implementation WARoomCatchSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WARoomCatchSuccessView" owner:self options:nil];
        [self addSubview:_thisView];
        
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 15;//
        _backView.layer.borderWidth = 5;
        _backView.layer.borderColor =[UIColor clearColor].CGColor;
        
        _helpBtn.layer.masksToBounds = YES;
        _helpBtn.layer.cornerRadius = 15;//
        _helpBtn.layer.borderWidth = 5;
        _helpBtn.layer.borderColor =[UIColor clearColor].CGColor;
        
        _repeatBtn.layer.masksToBounds = YES;
        _repeatBtn.layer.cornerRadius = 15;//
        _repeatBtn.layer.borderWidth = 5;
        _repeatBtn.layer.borderColor =[UIColor clearColor].CGColor;
        
        
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
