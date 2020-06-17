//
//  AddSpecs_nameContentCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/15.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddSpecs_nameCellDelegate <NSObject>

-(void)AddSpecs_nameCell:(NSDictionary  *)dict index:(NSInteger )index;

-(void)deleSpecs_nameIndex:(NSInteger )index;

@end
@interface AddSpecs_nameContentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *contentTf;
@property (strong, nonatomic) IBOutlet UIButton *deleBtn;
@property (nonatomic,weak)id <AddSpecs_nameCellDelegate>  delgate;
@property (assign, nonatomic) NSInteger index;

-(void)reloadData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
