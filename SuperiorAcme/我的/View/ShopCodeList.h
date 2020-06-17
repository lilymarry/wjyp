//
//  ShopCodeList.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopCodeListDelegate <NSObject>
@optional
-(void)selectShopCodeListData:(NSDictionary *)dic state:(NSString *)state;

@end

@interface ShopCodeList : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *shopArr;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSString *state;
@property(weak,nonatomic) id <ShopCodeListDelegate>dDelegate;
- (instancetype)initWithFrame:(CGRect)frame;
-(void)reloadTable;

@end
