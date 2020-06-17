//
//  SEvaCar_header.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaCar_header.h"
#import "RatingBar.h"

@implementation SEvaCar_header

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _pre_moneyR.layer.masksToBounds = YES;
    _pre_moneyR.layer.cornerRadius = 3;
    
    RatingBar * star1 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenW - 170,0, 170, 50)];
    star1.starNumber = 4;
    star1.enable = YES;
    star1.viewColor = [UIColor clearColor];
    star1.starNum = ^(int starNum) {
        if (self.SEvaCar_header_StarNum) {
            self.SEvaCar_header_StarNum(0,starNum);
        }
    };
    [_oneStar addSubview:star1];
    
    RatingBar * star2 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenW - 170,0, 170, 50)];
    star2.starNumber = 4;
    star2.enable = YES;
    star2.viewColor = [UIColor clearColor];
    star2.starNum = ^(int starNum) {
        if (self.SEvaCar_header_StarNum) {
            self.SEvaCar_header_StarNum(1,starNum);
        }
    };
    [_twoStar addSubview:star2];
    
    RatingBar * star3 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenW - 170,0, 170, 50)];
    star3.starNumber = 4;
    star3.enable = YES;
    star3.viewColor = [UIColor clearColor];
    star3.starNum = ^(int starNum) {
        if (self.SEvaCar_header_StarNum) {
            self.SEvaCar_header_StarNum(2,starNum);
        }
    };
    [_threeStar addSubview:star3];
    
    RatingBar * star4 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenW - 170,0, 170, 50)];
    star4.starNumber = 4;
    star4.enable = YES;
    star4.viewColor = [UIColor clearColor];
    star4.starNum = ^(int starNum) {
        if (self.SEvaCar_header_StarNum) {
            self.SEvaCar_header_StarNum(3,starNum);
        }
    };
    [_fourStar addSubview:star4];
    
    RatingBar * star5 = [[RatingBar alloc] initWithFrame:CGRectMake(ScreenW - 170,0, 170, 50)];
    star5.starNumber = 4;
    star5.enable = YES;
    star5.viewColor = [UIColor clearColor];
    star5.starNum = ^(int starNum) {
        if (self.SEvaCar_header_StarNum) {
            self.SEvaCar_header_StarNum(4,starNum);
        }
    };
    [_fiveStar addSubview:star5];
}

@end
