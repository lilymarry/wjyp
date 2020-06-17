//
//  SHouseInfor_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SHouseInfor_top_choiceBlock) (NSString * label_id);

@interface SHouseInfor_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCollect_HHH;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *starView_num;
@property (strong, nonatomic) IBOutlet UILabel *num_label;

- (void)showModel:(NSArray *)arr andNow:(NSString *)label_id andType:(NSString *)type;
@property (nonatomic, copy) SHouseInfor_top_choiceBlock SHouseInfor_top_choice;
@end
