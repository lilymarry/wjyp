//
//  CustomLabel.h

//
//  Created by 科技沃天 on 2018/4/16.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 自定义Label,实现Label的内边距的设置
@interface CustomLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙
//添加图片,实现图文混排
-(void)LabelAddImageWithImageName:(NSString *)imageName;
@end
