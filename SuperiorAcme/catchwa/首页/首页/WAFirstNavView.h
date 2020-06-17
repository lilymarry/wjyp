//
//  WAFirstNavView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/2.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAFirstNavView : UIView

@property (nonatomic ,copy) NSArray *arrData;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIView *view_scroll;
@property (weak, nonatomic) IBOutlet UIButton *btn_guanzhu;
@property (weak, nonatomic) IBOutlet UIButton *btn_exit;



@end

NS_ASSUME_NONNULL_END
