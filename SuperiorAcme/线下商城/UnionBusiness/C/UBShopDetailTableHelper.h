//
//  UBShopDetailTableHelper.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+customGetCurrentUIViewController.h"
#import "UBNBShopInfoCellHelper.h"

typedef UIViewController *(^ViewControllerGenerator)(id params);

typedef void(^CompletionHandler)(UBShopDetailModel *shopDetailModel);

@interface UBShopDetailTableHelper : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) ViewControllerGenerator VCGenerator;
@property (copy, nonatomic) NSString * usid;

+(instancetype)instanceWithMerchant_id:(NSString *)merchant_id
                             tableView:(UITableView *)tableView;

- (UITableView *)tableView;

//-(void)fetchData;

//- (void)fetchDataWihtCompletionHandler:(CompletionHandler)CompletionHandler;

- (void)fetchDataWihtPara:(NSDictionary *)para completionHandler:(CompletionHandler)completionHandler;


@end
