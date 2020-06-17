//
//  DynamicAlertMes.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicAlertMes : UIView

/// 用户头像
@property (nonatomic, strong) UIImageView * avatarImageView;
/// 用户昵称
@property (nonatomic, strong) UILabel * nickNameLabel;
/// 内容
@property (nonatomic, strong) UILabel * contentLabel;


/**
 给UI控件赋值

 @param data 数据包
 */
- (void)settingValues:(NSDictionary *)data;

@end
