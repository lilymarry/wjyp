//
//  SPromotion_OPEN.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SPromotion_OPEN_BackBlock) ();

@interface SPromotion_OPEN : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;

- (void)showModel:(NSArray *)arr andType:(NSString *)type andClassType:(NSString *)classType andTypeContent:(NSString *)content;

@property (nonatomic, copy) SPromotion_OPEN_BackBlock SPromotion_OPEN_Back;
@end
