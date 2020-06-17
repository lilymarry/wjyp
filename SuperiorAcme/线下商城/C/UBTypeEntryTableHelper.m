//
//  UBTypeEntryTableHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBTypeEntryTableHelper.h"
#import "UBNearByShopCell.h"
#import "UBNearByShopDiscountTicketCell.h"


@interface UBTypeEntryTableHelper()<UITableViewDelegate,UITableViewDataSource,DZMSegmentedControlDelegate>
{
    UBTypeEntryModel *_entryTypeModel;
   // NSString * little_cate;
   
  
}
@property (nonatomic, copy) NSString *top_cate;


@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UBTypeEntryModel *model;
@property (nonatomic, strong) SAAPIHelper *apiHelper;


@property (nonatomic, strong) NSMutableArray * NearByShopList;

@end

@implementation UBTypeEntryTableHelper


+(instancetype)instanceWithTypeModel:(UBTypeModel *)typeModel
                             tableView:(UITableView *)tableView
{
    return [[[self class] alloc] initWithTypeModel:typeModel
                                        tableView:tableView];
    
}

-(void)setTypeModel:(UBTypeModel *)typeModel{
    _typeModel = typeModel;
    self.top_cate = typeModel.rec_type_id ?: @"";
    _headView.typeModel = _typeModel;
}

-(instancetype)initWithTypeModel:(UBTypeModel *)typeModele
                         tableView:(UITableView *)tableView{
    if (self = [super init]){
        self.typeModel = typeModele;
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.separatorStyle = 0;
        //little_cate=@"";
        [UBNearByShopCell xibWithTableView:self.tableView];
        [UBNearByShopDiscountTicketCell xibWithTableView:self.tableView];
        self.apiHelper = [SAAPIHelper new];
        
        _headView = [UBTypeEntryHeadView instanceWithXIB];
        _headView.frame = CGRectMake(0, 0, ScreenW, 240);
        _headView.typeModel = self.typeModel;
        _headView.segControl.delegate = self;
       
        if (_little_cate.length==0) {
            _little_cate=@"";
        }
        
        MJWeakSelf;
        _headView.firstLevelBtnBlock = ^(UBTypeModel *typeModel) {
            if (weakSelf.popUpViewBlock) {
                weakSelf.popUpViewBlock(typeModel);
            }
        };
        
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf fetchDataWithTop_cate:weakSelf.top_cate
                                little_cate:weakSelf.little_cate
                                   Complete:nil];
        }];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.apiHelper loadMoreOfflineStore_offlineStoreList_lng:GET_LNG
                                                                      lat:GET_LAT
                                                              merchant_id:@""
                                                                 top_cate:weakSelf.top_cate
                                                              little_cate:weakSelf.little_cate
                                                               completion:^(BOOL isSuccess, NSString *message, id result) {
                                                                  [weakSelf.tableView.mj_footer endRefreshing];
                                                                   if (isSuccess) {
                                                                       [weakSelf reloadDataWithDatas:result];
                                                                   }else{
                                                                       [MBProgressHUD showSuccess:message toView:weakSelf.tableView];
                                                                       [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                                                                   }
                                                               }];
        }];
    }
     return self;
}

#pragma mark - fetchData

- (void)requestBannerData{
    [SAAPIHelper offlineStore_stageAdsWithTop_cate:_top_cate
                                        completion:^(BOOL isSuccess, NSString *message, id result) {
                                            if (isSuccess) {
                                                if (!_tableView.tableHeaderView) {
                                                    _tableView.tableHeaderView = _headView;
                                                }
                                                [_headView reloadBannerData:result];
                                            }
                                        }];
}

-(void)fetchDataWithTop_cate:(NSString *)top_cate
                 little_cate:(NSString *)little_cate
                    Complete:(NetworkCompletionHandler)completion{
    [_apiHelper refreshOfflineStore_offlineStoreList_lng:GET_LNG
                                                     lat:GET_LAT
                                             merchant_id:@""
                                                top_cate:top_cate
                                             little_cate:little_cate
                                              completion:^(BOOL isSuccess, NSString *message, id result) {
                                                  [self.tableView.mj_header endRefreshing];
                                                         if (isSuccess) {
                                                             [self.NearByShopList removeAllObjects];
                                                             [self reloadDataWithDatas:result];
                                                             [self.tableView.mj_footer resetNoMoreData];
                                                             [self requestBannerData];  //请求轮播图
                                                         }else{
                                                             [self.NearByShopList removeAllObjects];
                                                             [self.tableView reloadData];
                                                             [MBProgressHUD tipView:message];
                                                         }
                                                  !completion ?: completion(isSuccess,message,result);
                                                     }];
}


-(void)reloadDataWithDatas:(id)data{
    _entryTypeModel = nil;
    _entryTypeModel = data;
    [self.NearByShopList addObjectsFromArray:_entryTypeModel.data];
    [self.tableView reloadData];
    
    [_headView reloadDataWithDatas:_entryTypeModel.nums index:_segSelectIndex];
}

-(void)segmentControl:(DZMSegmentedControl *)segmentedControl
           clickIndex:(NSInteger)index{
    if(index == _segSelectIndex){
        return;
    }
    UBTypeModel *tmpModel = nil;
    if (index == 0) {
          _little_cate=@"";
    }else{
        tmpModel = _entryTypeModel.nums[index - 1];
        _little_cate=tmpModel.rec_type_id;
    }
    [MBProgressHUD showMessage:nil toView:self.tableView];
    MJWeakSelf;
    _segSelectIndex = index;
    [self fetchDataWithTop_cate:_typeModel.rec_type_id
                    little_cate:_little_cate
                       Complete:^(BOOL isSuccess, NSString *message, id result) {
                           [MBProgressHUD hideAllHUDsForView:weakSelf.tableView animated:YES];
                       }];
}

-(NSMutableArray *)NearByShopList{
    if (!_NearByShopList) {
        _NearByShopList = [NSMutableArray array];
    }
    return _NearByShopList;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.NearByShopList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SOffLineNearbyStoreListModel * model = self.NearByShopList[section];
    return model.RowCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section];
    if (indexPath.row == 0){
        UBNearByShopCell *cell = [tableView dequeueReusableCellWithIdentifier:[UBNearByShopCell cellIdentifer] forIndexPath:indexPath];
        cell.nearByStoreModel = model;
        cell.selectionStyle = 0;
        return cell;
    }else{
        UBNearByShopDiscountTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:[UBNearByShopDiscountTicketCell cellIdentifer] forIndexPath:indexPath];
        if (model.user_id==0||model.show_type ==2) {
            cell.discountTicketTipLabel.hidden=YES;
            cell.aviliableDiscountTicketLabel.hidden=YES;
            cell.showMoreDiscountTicketBtn.hidden=YES;
        }
        else
        {
            cell.discountTicketTipLabel.hidden=NO;
            cell.aviliableDiscountTicketLabel.hidden=NO;
            cell.showMoreDiscountTicketBtn.hidden=NO;
        }
        SOffLineNearbyStoreListModel * ticketModel = model.ticket[indexPath.row - 1];
        cell.nearByStoreTikcetModel = ticketModel;
        cell.ShowMoreDiscountTicketBlock = ^(BOOL isCLick){
            model.RowCount = isCLick?model.ticket.count + 1:2;
            ticketModel.isClick = isCLick;
            [tableView reloadData];
        };
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectRowBlock) {
        SOffLineNearbyStoreListModel *model = self.NearByShopList[indexPath.section];
        self.didSelectRowBlock(model);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row!=0) {
            SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section];
            if (model.user_id==0||model.show_type ==2) {
                return 0;
            }
        }
   
    return UITableViewAutomaticDimension;
}


@end
