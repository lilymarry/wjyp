//
//  UBTypeEntryTableHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAAPIHelper.h"
#import "UBTypeEntryHeadView.h"

typedef void(^popUpViewAction)(UBTypeModel *typeModel);
typedef void(^didSelectRowAction)(SOffLineNearbyStoreListModel *model);

@interface UBTypeEntryTableHelper : NSObject

@property (nonatomic, strong) UBTypeEntryHeadView *headView;
@property (nonatomic, assign) NSInteger segSelectIndex;

@property (nonatomic, strong) UBTypeModel *typeModel;

@property (nonatomic, copy) popUpViewAction popUpViewBlock;

@property (nonatomic, copy) didSelectRowAction didSelectRowBlock;
@property (nonatomic, copy) NSString *little_cate;
+(instancetype)instanceWithTypeModel:(UBTypeModel *)typeModel
                           tableView:(UITableView *)tableView;

-(void)fetchDataWithTop_cate:(NSString *)top_cate
                 little_cate:(NSString *)little_cate
                    Complete:(NetworkCompletionHandler)completion;

@end
