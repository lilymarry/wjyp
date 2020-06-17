//
//  SSPurchase_header.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSPurchase_header.h"
#import "QGoodsInfor_first_header3_evaCollect.h"
@interface SSPurchase_header()
{
    QGoodsInfor_first_header3_evaCollect * coll;
}
@end
@implementation SSPurchase_header

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SSPurchase_header" owner:self options:nil];
        [self addSubview:_thisView];
        
        _lineView.layer.masksToBounds = YES;
        _lineView.layer.cornerRadius = 5;

        _ticket_buy_discount.layer.masksToBounds = YES;
        _ticket_buy_discount.layer.cornerRadius = 3;
        _songR.layer.masksToBounds = YES;
        _songR.layer.cornerRadius = _songR.frame.size.width/2;
        _delPrice.layer.masksToBounds = YES;
        _delPrice.layer.cornerRadius = 3;
        
        coll = [[QGoodsInfor_first_header3_evaCollect alloc] initWithFrame:CGRectMake(10, 0, ScreenW - 20, 100)];
        [_showCollect addSubview:coll];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

- (void)showModel:(NSArray *)arr {
    [coll showModel:arr andType:@"搭配购"];
}
@end
