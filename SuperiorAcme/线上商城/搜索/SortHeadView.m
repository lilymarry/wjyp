//
//  SortHeadView.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SortHeadView.h"
#import "SortHeadPriceView.h"

@interface SortHeadView()


@property (weak, nonatomic) IBOutlet UIButton *price_btn;

@property (weak, nonatomic) IBOutlet UIView *c_content_view;
//遮盖层
@property (nonatomic, strong) UIView *overView;

@property (nonatomic, strong) UIButton *tmpBtn;

@end


@implementation SortHeadView

-(void)awakeFromNib{
    [super awakeFromNib];
    UIButton *btn = self.price_btn;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(btn.imageView.frame.size.width), 0, (btn.imageView.frame.size.width))];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.titleLabel.frame.size.width), 0, -(btn.titleLabel.frame.size.width))];
    
    for (UIButton *btn in self.c_content_view.subviews) {
        [btn setTitleColor:UIColorHex(0x777777) forState:0];
        [btn setTitleColor:UIColorHex(0xFF5A5F) forState:1<<2];
    }
}

+(instancetype)instaceWithXIB{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                         owner:nil
                                       options:nil].firstObject;
}


- (IBAction)sortBtnAction:(UIButton *)sender {
    if (_tmpBtn == nil) {
        sender.selected = YES;
        _tmpBtn = sender;
    }else if (_tmpBtn != nil && sender != _tmpBtn){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
    
    if ([_para_order isEqualToString:@"1"]) {
        [_price_btn setImage:[UIImage imageNamed:@"search_up"] forState:0];
    }else if ([_para_order isEqualToString:@"2"]){
        [_price_btn setImage:[UIImage imageNamed:@"search_down"] forState:0];
    }
    self.overView.alpha = (sender.tag == 55);
    if (self.sortBlock) {
        self.sortBlock(sender, @[@"integral",@"tsort",@"sell",@""][sender.tag - 52],sender.tag == 55);
    }
    
}


-(void)otherViewSettingWithSuperView:(UIView *)superView
                  isContenNaviHeight:(BOOL)isContenNaviHeight{
    CGFloat y = isContenNaviHeight ? NAVIGATION_BAR_HEIGHT : 0 + [SortHeadView barviewHeight];
    NSLog(@"%@",@(y));
    self.overView = [[UIView alloc] initWithFrame:CGRectMake(0, y, ScreenW, ScreenH - y)];
    self.overView.alpha = 0;
    self.overView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.25];
    [superView addSubview:self.overView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                          action:@selector(tapAction:)];
//    [self.overView addGestureRecognizer:tap];
    
    SortHeadPriceView *priceView = [SortHeadPriceView instaceWithXIB];
    [self.overView addSubview:priceView];
    priceView.frame = CGRectMake(0, 0, ScreenW, 187 * ScreenW / 414);
    
    MJWeakSelf;
    priceView.block = ^(NSString *orderStr, NSString *fliterStr) {
        weakSelf.para_order  = orderStr;
        weakSelf.para_fliter = fliterStr;
        [weakSelf sortBtnAction:weakSelf.price_btn];
    };
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
//    [MBProgressHUD showError:@"点我" toView:self.overView.superview];
}

+(CGFloat)barviewHeight{
    return 57.0f;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
