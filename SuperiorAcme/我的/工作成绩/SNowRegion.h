//
//  SNowRegion.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SNowRegion_choiceBlock) ();

@interface SNowRegion : UIViewController

@property (nonatomic, copy) SNowRegion_choiceBlock SNowRegion_choice;
@end
