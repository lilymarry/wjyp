//
//  SCallNumAll.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SCallNumAll_closeBlock) ();

@interface SCallNumAll : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UILabel *thisNum;

- (void)showModel:(NSArray *)arr;
@property (nonatomic, copy) SCallNumAll_closeBlock SCallNumAll_close;
@end
