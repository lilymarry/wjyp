//
//  SgiftListTopReusableView1.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SgiftListModel.h"
@protocol SgiftListTopReusableViewDelegate <NSObject>

-(void)selectBtnClick:(SgiftListModel *)model;

@end
@interface SgiftListTopReusableView1 : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (weak,nonatomic) id<SgiftListTopReusableViewDelegate> delegate;
@end
