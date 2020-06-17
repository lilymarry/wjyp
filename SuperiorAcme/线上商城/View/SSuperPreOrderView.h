//
//  SSuperPreOrderView.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SSuperPreOrderViewSuccessBlock) (NSString * country_id, NSString * country_name);

@interface SSuperPreOrderView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UICollectionView *mCollect;

- (void)showModel:(NSArray *)arr;
@property (nonatomic, copy) SSuperPreOrderViewSuccessBlock SSuperPreOrderViewSuccess;
@end
