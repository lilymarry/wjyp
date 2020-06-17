//
//  PDGUserProtcolView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

typedef void(^sureRuleAction)(void);

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface TimerHelper : NSObject

- (void)createTimerWithTime:(int)time;

- (void)createTimerWithTime:(int)time Btn:(UIButton *)btn;

@end


@interface PDGUserProtcolView : UIView


/**
 确定按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


@property(copy,nonatomic)sureRuleAction block;

+(instancetype)instancePDGProtcolView;

-(void)configerData:(id)data;

@end
