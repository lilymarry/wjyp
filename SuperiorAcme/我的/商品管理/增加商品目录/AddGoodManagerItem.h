//
//  AddGoodManagerItem.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/25.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OsManageListModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AddGoodManagerItemDelegate <NSObject>
//刷新
-(void)refrechtView;
@end
@interface AddGoodManagerItem : UIViewController
@property(nonatomic ,strong)NSString *type; //type 1 新增 2 修改 3 
@property (strong, nonatomic) OsManageListModel *model;
@property(nonatomic ,strong)NSString *sta_mid;

@property (nonatomic,weak)id <AddGoodManagerItemDelegate>  delgate;
@end

NS_ASSUME_NONNULL_END
