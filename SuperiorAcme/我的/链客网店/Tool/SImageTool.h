//
//  SImageTool.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChoiceImageCallBakBlock)(UIImage * choiceImage);

@interface SImageTool : NSObject
@property (nonatomic, strong) UIImage * reSetShopIconImage;

/**
 用于弹出图片选择器的控制器
 */
@property (nonatomic, weak) UIViewController * vc;

/**
 图片选择完毕的回调
 */
@property (nonatomic, copy) ChoiceImageCallBakBlock choiceImageCallBackBlock;

//从系统相册获取图片
-(void)ChoiceImageFromAlbums;
//拍照获取图片
- (void)ChoiceImageFromCamera;
@end
