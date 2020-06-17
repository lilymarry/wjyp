//
//  AShare.h
//  AntLeader
//
//  Created by TXD_air on 2017/3/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AShare_backBlock) ();

@interface AShare : UIViewController
@property (nonatomic, copy) NSString * thisImage;
@property (nonatomic, copy) NSString * thisTitle;
@property (nonatomic, copy) NSString * thisContent;
@property (nonatomic, copy) NSString * thisUrl;
@property (nonatomic, copy) NSString * thisType;//1 商品 2商家 3书院 4红包 5其他(个人中心) 6参团
@property (nonatomic, copy) NSString * id_val;//对应的id 商品传商品id 依次.... 个人中心的分享id我给你们

@property (nonatomic, copy) AShare_backBlock AShare_back;
- (void)backClick;
@end
