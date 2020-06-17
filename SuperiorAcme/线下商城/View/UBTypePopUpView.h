//
//  UBTypePopUpView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/22.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBTypeModel.h"

typedef void(^firstLevelDidSelectRowAction)(UBTypeModel *typeModel);

/*
  btn上得文字可以通过 firstLevel和 select_row 获取 model
  如果是点击的 顶部按钮/二级的全部系列 不需要返回 二级id
  如果点击的 二级 需要把 二级id 传过去
 */
typedef void(^popViewClickAction)(UBTypeModel *firstLevelModel,UBTypeModel *secondLevelModel ,NSInteger index);


@interface UBTypePopUpView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UBTypeModel *typeModel;

@property (weak, nonatomic) IBOutlet UITableView *firstLevelTableView;

@property (weak, nonatomic) IBOutlet UITableView *secondLevelTableView;

@property (nonatomic, strong) NSMutableArray *firstLevelDatas;

@property (nonatomic, strong) NSMutableArray *secondLevelDatas;

@property (nonatomic, copy) firstLevelDidSelectRowAction firstLevelDidSelectRowBlcok;

@property (nonatomic, copy) popViewClickAction popViewClickBlock;


+(instancetype)instanceWithXIB;

@end
