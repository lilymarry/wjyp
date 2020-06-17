//
//  WASignInSuccessView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetRoomListModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^sureBtnAction)(void);
@interface WASignInSuccessView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property(copy,nonatomic)sureBtnAction block;

-(void)getData:(GetRoomListModel *)model ;
@end

NS_ASSUME_NONNULL_END
