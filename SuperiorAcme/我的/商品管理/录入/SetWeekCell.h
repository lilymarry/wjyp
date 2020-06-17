//
//  SetWeekCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/18.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  SetWeekCellDelegate <NSObject>

-(void) setWeekCell:(NSDictionary  *)dict index:(NSInteger  )index;

@end
@interface SetWeekCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tittleLab;
@property (strong, nonatomic) IBOutlet UITextField *contextTf;


@property (strong, nonatomic) IBOutlet UITextField *subContextTf;


@property (assign, nonatomic)NSInteger index;
@property (nonatomic,weak)id <SetWeekCellDelegate>  delgate;
@end

NS_ASSUME_NONNULL_END
