//
//  SFeed_NewContent.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SFeed_NewContent_BackBlock) (NSString * contentTV);

@interface SFeed_NewContent : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextView *contentTV;

@property (nonatomic, copy) SFeed_NewContent_BackBlock SFeed_NewContent_Back;

@property (strong, nonatomic) IBOutlet UILabel *real_name;
@property (strong, nonatomic) IBOutlet UILabel *user_id;
- (void)showModel:(NSString *)real_name andUser_id:(NSString *)user_id;
@end
