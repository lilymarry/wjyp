//
//  WARoomCatchSuccessView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WARoomCatchSuccessView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *repeatBtn;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *repeatBtnww;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *helpBtnWW;
@property (strong, nonatomic) IBOutlet UIButton *exitBtn;



@end

NS_ASSUME_NONNULL_END
