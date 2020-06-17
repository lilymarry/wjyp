//
//  WAInRoomTopView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/11.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^tapOrientationBlock)(NSInteger type);
@interface WAInRoomTopView : UIView

@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MainCatchViewHHH;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *chargBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *startCatchBtn;


@property (weak, nonatomic) IBOutlet UIView *handelView;


@property (strong, nonatomic) IBOutlet UIView *videoView;

@property (nonatomic, copy) tapOrientationBlock tapOrientaBlock;

@property (strong, nonatomic) IBOutlet UIButton *cameraBtn;

@property (strong, nonatomic) IBOutlet UILabel *room_id_lab;
@property (strong, nonatomic) IBOutlet UILabel *spentLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;

@property (strong, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic) IBOutlet UIButton *timeBtn;


-(void)getData:(NSArray *)data;


@end

NS_ASSUME_NONNULL_END
