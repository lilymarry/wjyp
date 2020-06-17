//
//  CommodityMerchant.m
//  HousePerson
//
//  Created by TXD_air on 16/11/8.
//  Copyright © 2016年 GYM. All rights reserved.
//

#import "CommodityMerchant.h"

@implementation CommodityMerchant

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"CommodityMerchant" owner:self options:nil];
        [self createUI];
        
        
    }
    return self;
}

- (void)createUI {
    _thisContent.frame = CGRectMake(0, 0, 80, 70);
    [self addSubview:_thisContent];
    
}

@end
