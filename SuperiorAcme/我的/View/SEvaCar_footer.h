//
//  SEvaCar_footer.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SEvaCar_footer_CloseBlock) (NSInteger num);
typedef void(^SEvaCar_footer_ChoiceBlock) (NSMutableArray * arr);
typedef void(^SEvaCar_footer_LookBlock) (NSArray * arr, NSInteger num);

@interface SEvaCar_footer : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet UITextView *evaTV;

@property (nonatomic, copy) SEvaCar_footer_CloseBlock SEvaCar_footer_Close;
- (void)closeShow:(NSInteger)num;

@property (nonatomic, copy) SEvaCar_footer_ChoiceBlock SEvaCar_footer_Choice;
- (void)choiceShow:(NSMutableArray *)arr;

@property (nonatomic, copy) SEvaCar_footer_LookBlock SEvaCar_footer_Look;
@end
