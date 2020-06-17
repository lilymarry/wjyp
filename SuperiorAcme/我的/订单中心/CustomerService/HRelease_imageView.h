//
//  HRelease_imageView.h
//  HouseCenter
//
//  Created by TXD_air on 16/8/29.
//  Copyright © 2016年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
//选择图片
typedef void(^HRelease_imageViewChoiceBlock) (UIButton * btn);
//观看图片
typedef void(^HRelease_imageViewLookBlock) (NSInteger num);
//删除图片
typedef void(^HRelease_imageViewCloseBlock) (NSInteger num);

@interface HRelease_imageView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisContent;
@property (nonatomic, strong) UICollectionView * mCollectionView;
@property (nonatomic, copy) HRelease_imageViewChoiceBlock HRelease_imageViewChoice;

- (void)setChoiceImage:(NSMutableArray *)arr;
@property (nonatomic, copy) HRelease_imageViewLookBlock HRelease_imageViewLook;
@property (nonatomic, copy) HRelease_imageViewCloseBlock HRelease_imageViewClose;
@end
