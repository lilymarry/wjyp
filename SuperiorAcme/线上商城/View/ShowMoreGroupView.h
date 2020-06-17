//
//  ShowMoreGroupView.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/6/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGroupBuyGroupBuyInfo.h"

typedef void(^JumpFightGroupsBlock)(SGroupBuyGroupBuyInfo *);

@interface ShowMoreGroupView : UIView
//外界传进来的拼单信息数组
@property (nonatomic, strong) NSArray * groupArr;
//展示拼单信息的cell
@property (weak, nonatomic) IBOutlet UICollectionView *MoreGroupCollection;
//点击拼单的cell的跳转的回调
@property (nonatomic, copy) JumpFightGroupsBlock jumpFightGroupBlock;


//通过xib创建ShowMoreGroupView视图
+(instancetype)CreatShowMoreGroupView;



@end
