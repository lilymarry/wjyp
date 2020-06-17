//
//  AddAttr_nameCell.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/14.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddAttr_nameCellDelegate <NSObject>

-(void)AddAttr_nameCell:(NSDictionary  *)dict index:(NSInteger )index;

-(void)deleAttr_nameCellIndex:(NSInteger )index;

@end
@interface AddAttr_nameCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *nameTf;
@property (strong, nonatomic) IBOutlet UITextField *priceTf;
@property (strong, nonatomic) IBOutlet UITextField *jisuanPriceTf;
@property (strong, nonatomic) IBOutlet UIButton *deleBtn;
@property (strong, nonatomic) IBOutlet UILabel *guigeNameLab;


@property (nonatomic,weak)id <AddAttr_nameCellDelegate>  delgate;
@property (assign, nonatomic) NSInteger index;

-(void)reloadDic:(NSDictionary *)dic;





@end

NS_ASSUME_NONNULL_END
