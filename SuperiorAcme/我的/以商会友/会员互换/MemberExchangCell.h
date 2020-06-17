//
//  MemberExchangCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberExchangCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headIma;

@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *leveLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@end

NS_ASSUME_NONNULL_END
