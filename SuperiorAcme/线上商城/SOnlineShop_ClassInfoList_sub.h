//
//  SOnlineShop_ClassInfoList_sub.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOnlineShop_ClassInfoList_sub : UIViewController
@property (nonatomic, copy) NSString * cate_type;//1:票券区 2:拼团购 3:无界商店 4:无界预购 5:进口馆 6:推荐类型子类型（推荐、食品、生鲜、服饰、家具、进口、美食）7:6类型的子分类（只有列表）8:好收成超市  
@property (nonatomic, copy) NSString * two_cate_id;//二级分类id
@property (nonatomic, copy) NSString * short_name;//二级分类简称

@property (nonatomic, copy) NSString * country_id;//国家id 5进口馆需要

@property (nonatomic, assign) NSInteger class_num;

//筛选视图
//@property (nonatomic, strong) SortHeadView *sortView;

@end
