//
//  CompleteUserView.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/11/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sureBtnAction)(void);
@interface CompleteUserView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) NSString *money;
@property(copy,nonatomic)sureBtnAction block;
@end
