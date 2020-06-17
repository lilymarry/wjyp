//
//  UBSearchTableHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/1.
//  Copyright © 2018年 GYM. All rights reserved.
//

#define CellID @"UBNearByShopCell"

#import "UBSearchTableHelper.h"
#import "UBNearByShopCell.h"

@interface UBSearchTableHelper()

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) SAAPIHelper *apiHelper;

@property (nonatomic, strong) NSMutableArray<SOffLineNearbyStoreListModel *> *searchs;


@end

@implementation UBSearchTableHelper

+ (instancetype)instanceWithKeyWord:(NSString *)keyword tableView:(UITableView *)tableView{
    return [[[self class] alloc] initWithKeyWord:keyword tableView:tableView];
}

- (instancetype)initWithKeyWord:(NSString *)keyword tableView:(UITableView *)tableView{
    if (self = [super init]) {
        self.tableView = tableView;
        self.keyword = SWNOTEmptyStr(keyword) ? keyword : @"";
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.separatorStyle = 0;
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.apiHelper = [SAAPIHelper new];
        MJWeakSelf;
        [self.tableView registerNib:[UINib nibWithNibName:CellID bundle:nil] forCellReuseIdentifier:CellID];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf fetchData];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.apiHelper loadMoreUnderLineSearchWithKeyWord:keyword
                                                        completion:^(BOOL isSuccess, NSString *message, id result) {
                                                            [weakSelf.tableView.mj_footer endRefreshing];
                                                            if (isSuccess) {
                                                                [weakSelf reloadDataWithModel:result];
                                                            }else{
                                                                [MBProgressHUD showSuccess:message toView:weakSelf.tableView];
                                                                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                                                            }
                                                        }];
        }];
        
    }
    return self;
}

//网络请求
- (void)fetchData{
    [self.apiHelper refreshUnderLineSearchWithKeyWord:self.keyword
                                               completion:^(BOOL isSuccess, NSString *message, id result) {
                                                   [self.tableView.mj_header endRefreshing];
                                                    [self.searchs removeAllObjects];
                                                   [self reloadDataWithModel:result];
                                                   [self.tableView.mj_footer resetNoMoreData];
                                                   if (!isSuccess) {
                                                       [MBProgressHUD showSuccess:message toView:self.tableView];
                                                   }
                                               }];
    
}

-(void)reloadDataWithModel:(NSArray *)result{
    for (SOffLineNearbyStoreListModel *model in result) {
        model.isSearch = YES;
        [self.searchs addObject:model];
    }
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UBNearByShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.nearByStoreModel = self.searchs[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    !self.didSelectRowBlock ?:self.didSelectRowBlock(self.searchs[indexPath.row]);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchs.count;
}

-(NSMutableArray<SOffLineNearbyStoreListModel *> *)searchs{
    if (!_searchs) {
        _searchs = [NSMutableArray array];
    }
    return _searchs;
}

@end
