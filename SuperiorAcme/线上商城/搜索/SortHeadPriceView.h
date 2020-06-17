//
//  SortHeadPriceView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/10.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define UIColorHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#import <UIKit/UIKit.h>

typedef void(^sureBtnAction)(NSString *orderStr,NSString *fliterStr);

@interface SortHeadPriceView : UIView

@property (weak, nonatomic) IBOutlet UITextField *priceLowerTF;

@property (weak, nonatomic) IBOutlet UITextField *priceHigherTF;

@property (weak, nonatomic) IBOutlet UIButton *low_to_high_btn;

@property (weak, nonatomic) IBOutlet UIButton *high_to_low_btn;

@property (weak, nonatomic) IBOutlet UIView *fliterView;

@property (weak, nonatomic) IBOutlet UIView *sortView;

@property (nonatomic, copy) sureBtnAction block;



+(instancetype)instaceWithXIB;

@end
