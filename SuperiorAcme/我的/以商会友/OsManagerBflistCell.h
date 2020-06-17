//
//  OsManagerBflistCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OsManagerBflistCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headIma;

@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UIImageView *selectImaView;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headImaWWW;
@property (strong, nonatomic) IBOutlet UILabel *friendLab;





@end

NS_ASSUME_NONNULL_END
