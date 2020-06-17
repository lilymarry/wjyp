//
//  UBTypeEntryHeadView.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZMSegmentedControl.h"
#import "UBTypeModel.h"

typedef void(^firstLevelBtnAction)(UBTypeModel *typeModel);

@interface UBTypeEntryHeadView : UIView

@property (weak, nonatomic) IBOutlet UIView *bannerView;

/**
 二级分类
 */
@property (weak, nonatomic) IBOutlet UIView *secondLevalView;

@property (nonatomic, strong) DZMSegmentedControl *segControl;

@property (nonatomic, strong) UBTypeModel *typeModel;

//分类只展示文字
@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, copy) firstLevelBtnAction firstLevelBtnBlock;

+(instancetype)instanceWithXIB;

-(void)reloadDataWithDatas:(NSArray *)datas index:(NSInteger)index;

-(void)reloadBannerData:(id)data;

@end
