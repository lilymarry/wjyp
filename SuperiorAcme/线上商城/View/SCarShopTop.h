//
//  SCarShopTop.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SCarShopTop_choiceBlock) (NSString * min_price, NSString * max_price);

@interface SCarShopTop : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *sliderView;
@property (strong, nonatomic) IBOutlet UILabel *thisPriceRange;

@property (nonatomic, copy) SCarShopTop_choiceBlock SCarShopTop_choice;
@end
