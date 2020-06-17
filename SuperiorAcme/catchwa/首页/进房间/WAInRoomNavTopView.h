//
//  WAInRoomNavTopView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/12.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAInRoomNavTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIButton *playerListBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIImageView *head1;
@property (strong, nonatomic) IBOutlet UIImageView *head2;
@property (strong, nonatomic) IBOutlet UIImageView *head3;
@property (strong, nonatomic) IBOutlet UIImageView *head4;

@property (strong, nonatomic) IBOutlet UILabel *nowLab1;
@property (strong, nonatomic) IBOutlet UILabel *nowLab2;
@property (strong, nonatomic) IBOutlet UIView *view1;

@property (strong, nonatomic) IBOutlet UIView *view2;




@end

NS_ASSUME_NONNULL_END
