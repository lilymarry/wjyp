//
//  SOrderInfor_Come.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOrderInfor_Come_choiceBlock) (NSString * type);

@interface SOrderInfor_Come : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *server;
@property (weak, nonatomic) IBOutlet UILabel *server_else;

@property (nonatomic, copy) SOrderInfor_Come_choiceBlock SOrderInfor_Come_choice;
@end
