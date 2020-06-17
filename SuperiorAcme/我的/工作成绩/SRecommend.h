//
//  SRecommend.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRecommend : UIViewController
@property (nonatomic, assign) BOOL type;//NO 我推荐的人 YES别人推荐的人
@property (nonatomic, copy) NSString * name;//type:YES 他的昵称

@property (nonatomic, copy) NSString * parent_id;//父级id 默认是自己的推荐人 传入值查看对应id 下的推荐人

/*
 *添加是否有权限无线查看属性
 */
@property (nonatomic, copy) NSString * infinite;//是否有权先可以无线查看
@end
