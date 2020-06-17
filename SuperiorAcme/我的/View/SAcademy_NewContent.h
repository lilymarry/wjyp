//
//  SAcademy_NewContent.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SAcademy_NewContent_ShowModelAgainBlock) ();
typedef void(^SAcademy_NewContent_inforBlock) (NSString * academy_id);
typedef void(^SAcademy_NewContent_bannerViewBlock) ();

@interface SAcademy_NewContent : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UITableView *mTable;

- (void)showModel:(NSArray *)arr andBanner:(NSArray *)bannerArr;
@property (nonatomic, copy) SAcademy_NewContent_ShowModelAgainBlock SAcademy_NewContent_ShowModelAgain;
@property (nonatomic, copy) SAcademy_NewContent_inforBlock SAcademy_NewContent_infor;
@property (nonatomic, copy) SAcademy_NewContent_bannerViewBlock SAcademy_NewContent_bannerView;
@end
