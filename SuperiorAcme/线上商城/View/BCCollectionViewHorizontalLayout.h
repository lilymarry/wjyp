//
//  BCCollectionViewHorizontalLayout.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCCollectionViewHorizontalLayout : UICollectionViewFlowLayout
//  一行中 cell 的个数
@property (nonatomic,assign) NSUInteger itemCountPerRow;

//    一页显示多少行
@property (nonatomic,assign) NSUInteger rowCount;
@end
