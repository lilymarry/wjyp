//
//  OsManagerBflistTopView.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManagerBflistTopView.h"

@interface OsManagerBflistTopView ()


@end

@implementation OsManagerBflistTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"OsManagerBflistTopView" owner:self options:nil];
        [self addSubview:_thisView];
        
        self.searchView.layer.cornerRadius = 20;
        self.searchView.layer.masksToBounds = YES;
       
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
