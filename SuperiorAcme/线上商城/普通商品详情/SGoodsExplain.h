//
//  SGoodsExplain.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/15.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SGoodsExplainBackBlock) ();

@interface SGoodsExplain : UIViewController
/*
 *添加是否是提示信息的判断
 */
@property (nonatomic, assign) BOOL isTips;

@property (nonatomic, copy) SGoodsExplainBackBlock SGoodsExplainBack;

- (void)showModel:(NSArray *)arr andType:(NSString *)overType andType:(NSString *)arrType;
@end
