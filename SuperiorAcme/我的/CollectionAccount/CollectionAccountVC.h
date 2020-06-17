//
//  CollectionAccountVC.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//  三方收款账户

#import <UIKit/UIKit.h>

@interface CollectionAccountVC : UIViewController

/*
 在输入或者设置密码之前验证账户余额 是否大于2，不大于的话就弹出截图中的对话框，充值就去充值界面，取消去个人中心
 */
@property (nonatomic, assign) BOOL isShowAlert;
@property (nonatomic, strong) NSString *shopId;
@end
