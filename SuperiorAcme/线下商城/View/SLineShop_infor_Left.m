//
//  SLineShop_infor_Left.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_infor_Left.h"
#import "SNPageView.h"
#import "STicketFight_NewContent.h"

@interface SLineShop_infor_Left () <UIScrollViewDelegate>
{
    STicketFight_NewContent * content;
}
@end

@implementation SLineShop_infor_Left

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_infor_Left" owner:self options:nil];
        [self addSubview:_thisView];
        
        SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 44 - 70 - 50 ) p_style:PageViewStyleLine];
        pageView.subViews = @[[STicketFight_NewContent class],[STicketFight_NewContent class],[STicketFight_NewContent class],[STicketFight_NewContent class],[STicketFight_NewContent class],[STicketFight_NewContent class],[STicketFight_NewContent class]];
        pageView.titles = @[@"全部",@"巧克力",@"巧克力",@"巧克力",@"巧克力",@"巧克力",@"巧克力"];
        pageView.titleWidth = 100;
        pageView.titleSelectedFont = [UIFont systemFontOfSize:14];
        pageView.sliderColor = WordColor;
        pageView.defaultSelectedIndex = 0;
        pageView.goundNormalColor = [UIColor whiteColor];
        pageView.customTag = 100;
        [pageView showInView:_thisView action:^(id subView, UIButton *btn, NSInteger index) {
            content = subView;
            [content thisType:@"8"];
            content.STicketFight_NewContent_ScrollDelegate = ^(CGFloat y) {
                if (self.SLineShop_infor_Left_ScollDelegate) {
                    self.SLineShop_infor_Left_ScollDelegate(y);
                }
            };
            content.STicketFight_NewContent_showR = ^{
                if (self.SLineShop_infor_Left_showR) {
                    self.SLineShop_infor_Left_showR();
                }
            };
            content.STicketFight_NewContent_infor = ^(NSString *goods_id,NSString *a_id) {
                if (self.SLineShop_infor_Left_infor) {
                    self.SLineShop_infor_Left_infor(goods_id);
                }
            };
            
        }];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
@end
