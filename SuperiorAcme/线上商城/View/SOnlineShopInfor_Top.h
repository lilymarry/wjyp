//
//  SOnlineShopInfor_Top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOnlineShopInfor_Top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (strong, nonatomic) IBOutlet UILabel *topContent;
@property (strong, nonatomic) IBOutlet UIButton *topShopBtn;
@property (strong, nonatomic) IBOutlet UIView *topSearchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UILabel *merchant_name;
@property (strong, nonatomic) IBOutlet UILabel *noticeTitle;
@property (strong, nonatomic) IBOutlet UIButton *noticeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;
- (void)type:(NSString *)choice;//1:店铺首页 2:全部商品 3热销商品 4热心上架 5活动商品

@end
