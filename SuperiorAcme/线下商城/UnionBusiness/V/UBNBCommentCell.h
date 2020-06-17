//
//  UBNBCommentCell.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UBNBCommentCell : UITableViewCell

@property (nonatomic, copy) NSString *head_pic;   //头像

@property (nonatomic, copy) NSString *nickname;   //昵称

@property (nonatomic, assign) NSInteger star;       //星级

@property (nonatomic, copy) NSString *start_time; //创建时间

//@property (nonatomic, copy) NSString *c_id;       //店铺ID

@end
