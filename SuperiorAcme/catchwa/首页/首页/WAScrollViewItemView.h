//
//  WAScrollViewItemView.h
//  imagview+lab横向滚动
//
//  Created by 天津沃天科技 on 2019/1/3.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WAScrollViewItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *headIconImaV;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@end

NS_ASSUME_NONNULL_END
