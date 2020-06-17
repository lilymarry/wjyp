//
//  SelectPickView.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TopBtnBlock)(NSString * name,NSString *flag,NSInteger index);
typedef void(^cancelBtnBlock)();
@interface SelectPickView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) TopBtnBlock topBtnBlock;
@property (nonatomic, copy) cancelBtnBlock cancelBlock;
-(void)getData:(NSArray *)arr flag:(NSString *)flag;
@end

NS_ASSUME_NONNULL_END
