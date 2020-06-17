//
//  GoodsManagerItemListCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/23.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OsManageListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^TopBtnBlock)(OsManageListModel* type);
@interface GoodsManagerItemListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UIButton *bianjibtn;

@property (nonatomic, copy) TopBtnBlock topBtnBlock;

@property (strong, nonatomic) OsManageListModel *model;


@end

NS_ASSUME_NONNULL_END
