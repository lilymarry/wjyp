//
//  SNowRegion_Top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/10.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SNowRegion_Top_myChoiceBlock) (NSString * name);

@interface SNowRegion_Top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

- (void)showModel:(NSArray *)arr;

@property (nonatomic, copy) SNowRegion_Top_myChoiceBlock SNowRegion_Top_myChoice;
@end
