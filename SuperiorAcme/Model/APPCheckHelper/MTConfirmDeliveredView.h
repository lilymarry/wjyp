//
//  MTConfirmDeliveredView.h
//  DinnerDistribution
//
//  Created by nian on 2017/12/1.
//  Copyright © 2017年 hanshanquan. All rights reserved.
//

typedef enum : NSUInteger {
    MTConfirmDeliveredViewType_NormalGengXin = 0,  //正常
    MTConfirmDeliveredViewType_QiangZhiGengXin,    //强制
    MTConfirmDeliveredViewType_ChangeAddress,      //改变地址  /  取消
} MTConfirmDeliveredViewType;

#import <Masonry.h>

/*  强制更新  */
@class MTConfirmDeliveredView;

@protocol MTConfirmDeliveredViewDelegate <NSObject>

@optional
//强制更新
- (void)qiangZhiGengXinMethod;
//更新
- (void)gengxinMethod;
//取消
- (void)quXiaoGengxinMethod;
//改变当前地址
- (void)notChangeAddressMethod;

@end

@interface MTConfirmDeliveredView : UIView

@property (nonatomic,copy)NSString *cusTitle;
@property (nonatomic,copy)NSString *cusContent; //提示内容
@property (nonatomic,strong)NSArray *cusBtnsTitle;
@property (nonatomic,assign)MTConfirmDeliveredViewType type;

@property (nonatomic,weak) id<MTConfirmDeliveredViewDelegate> delegate;
@property (nonatomic,strong)UIView *contentView;

- (void)viewShow;
- (void)viewDismiss;
/* 名曰  强制更新 */
- (id)initWithTitle:(NSString *)title content:(NSString *)content btnTitles:(NSArray *)btnTitles type:(MTConfirmDeliveredViewType)type;

@end
