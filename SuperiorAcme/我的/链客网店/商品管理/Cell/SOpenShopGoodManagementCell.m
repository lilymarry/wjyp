//
//  SOpenShopGoodManagementCell.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOpenShopGoodManagementCell.h"

@implementation SOpenShopGoodManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)shareOpenShopGoodClick:(UIButton *)sender {
    if (self.shareOpenShopGood) {
        self.shareOpenShopGood();
    }
}

@end
