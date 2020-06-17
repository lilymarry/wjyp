//
//  WANewPersonPriceView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WANewPersonPriceView.h"
#import "ChangeRoomStatus.h"
@interface WANewPersonPriceView ()

@end

@implementation WANewPersonPriceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WANewPersonPriceView" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


- (IBAction)surePress:(id)sender {
    [MBProgressHUD showMessage:nil toView:self];
    ChangeRoomStatus *status=[[ChangeRoomStatus alloc]init];
    status.type=@"3";
    [status ChangeRoomStatusSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message) {
         [MBProgressHUD hideAllHUDsForView:self animated:YES];
         [MBProgressHUD showSuccess:message toView:self];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self removeFromSuperview];
        });
    } andFailure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self];
    }];
    
   
    
}



@end
