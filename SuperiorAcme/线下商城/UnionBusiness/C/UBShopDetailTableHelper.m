//
//  UBShopDetailTableHelper.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/25.
//  Copyright © 2018年 GYM. All rights reserved.
//


#define kOfflineStore_offlineStoreInfo    @"OfflineStore/offlineStoreInfo"

#define ShopInvirmentIdentifier @"ShopInvirmentIdentifier"
#define UBNBCommentCellIdentifier NSStringFromClass([UBNBCommentCell class])
#define UBNearByShopCellIdentifier NSStringFromClass([UBNearByShopCell class])
#define UBNBShopInfoCellIdentifier NSStringFromClass([UBNBShopInfoCell class])
#define UBNBLookMerchant_ReportMerchantCellIdentifier NSStringFromClass([UBNBLookMerchant_ReportMerchantCell class])
#define UBNBShopInvirmentCellIdentifier NSStringFromClass([UBNBShopInvirmentCell class])
#define UBNearByShopDiscountTicketCellIdentifier  NSStringFromClass([UBNearByShopDiscountTicketCell class])

#import "UBShopDetailTableHelper.h"

#import "UBNBLookMerchant_ReportMerchantCell.h"
#import "UBNBShopInfoCell.h"
#import "UBNearByShopCell.h"
#import "UBNBCommentCell.h"
#import "UBNBSectionHeaderView.h"
#import "UBNBShopInvirmentCell.h"

#import "UBNBCommentCellHelper.h"
#import "SOffLineNearbyStoreListModel.h"
#import "UBNearByShopDiscountTicketCell.h"


#import "SEva.h"
#import "SReportingMerchant.h"
#import "SBusinessQualification.h"
#import "UBShopDetailController.h"

#import <BaiduMapAPI_Utils/BMKOpenRouteOption.h>
#import <BaiduMapAPI_Utils/BMKOpenRoute.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "HSQActionSheet.h"
#import "SlineDetailWebController.h"
@interface UBShopDetailTableHelper ()<SNBannerViewDelegate,HSQActionSheetDelegate>
{
    BOOL _isInstallGaoDeMap; //高德
    BOOL _isInstallBaiDuMap; //百度
    BOOL _isInstallSystomMap; //系统
}
@property (nonatomic, copy) NSString *merchant_id;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) UBShopDetailModel * shopDetailModel;
@property (nonatomic, strong) NSMutableArray<UBNBCommentCellHelper *> *comments;
@property (nonatomic, strong) UBNBShopInfoCellHelper *shopInfoHelper;

@property (nonatomic, strong) NSMutableArray * NearByShopList;
@end


@implementation UBShopDetailTableHelper

+(instancetype)instanceWithMerchant_id:(NSString *)merchant_id
                             tableView:(UITableView *)tableView
{
     return [[[self class] alloc] initWithMerchant_id:merchant_id
                                            tableView:tableView];
    
}


-(instancetype)initWithMerchant_id:(NSString *)merchant_id
                         tableView:(UITableView *)tableView{
    if (self = [super init]) {
        self.merchant_id = merchant_id ?: @"";
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.separatorStyle = 0;
        
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UBNBLookMerchant_ReportMerchantCell class]) bundle:nil] forCellReuseIdentifier:UBNBLookMerchant_ReportMerchantCellIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UBNBShopInfoCell class]) bundle:nil] forCellReuseIdentifier:UBNBShopInfoCellIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UBNBCommentCell class]) bundle:nil] forCellReuseIdentifier:UBNBCommentCellIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UBNearByShopCell class]) bundle:nil] forCellReuseIdentifier:UBNearByShopCellIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UBNBShopInvirmentCell class]) bundle:nil] forCellReuseIdentifier:UBNBShopInvirmentCellIdentifier];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UBNearByShopDiscountTicketCell class]) bundle:nil] forCellReuseIdentifier:UBNearByShopDiscountTicketCellIdentifier];
        
    }
    return self;
}

#pragma mark - UITableViewDataSource && Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3 + self.NearByShopList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            {
               return 1;
            }
            break;
        case 1: //评价
        {
            return self.comments.count > 2 ? 2 : self.comments.count;
        }
            break;
        case 2:
        {
            return self.shopInfoHelper.shopInfos.count + self.shopInfoHelper.lookAndReports.count ;
        }
            break;
        default:
        {
            SOffLineNearbyStoreListModel * model = self.NearByShopList[section - 3];
            return model.RowCount;
        }
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {  //店铺环境
        UBNBShopInvirmentCell *cell = [tableView dequeueReusableCellWithIdentifier:UBNBShopInvirmentCellIdentifier forIndexPath:indexPath];
        if (SWNOTEmptyArr(self.shopDetailModel.gallery) && !cell.bannerView) {
            float screenW=ScreenW - 30;
            
             SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(15, 10, screenW-30,screenW *618 / 1000) delegate:self model:self.shopDetailModel.gallery URLAttributeName:@"path" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
            [cell.contentView addSubview:cell.bannerView = banner];
        }
        cell.selectionStyle = 0;
        return cell;
    }else if (indexPath.section == 1){ //店铺评价
        UBNBCommentCellHelper *commentHelper = self.comments[indexPath.row];
        UBNBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:UBNBCommentCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = 0;
        cell.head_pic = commentHelper.head_pic;
        cell.nickname = commentHelper.nickname;
        cell.star = commentHelper.star;
        cell.start_time = commentHelper.start_time;
        return cell;
    }else if (indexPath.section == 2){ //店铺信息
        if (indexPath.row <= self.shopInfoHelper.shopInfos.count - 1) {
            UBNBShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:UBNBShopInfoCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = 0;
            NSDictionary *tmpDic = self.shopInfoHelper.shopInfos[indexPath.row];
            cell.messageLab.text = tmpDic[@"message"];
            cell.titleLab.text = tmpDic[@"title"];
     
            if ([tmpDic[@"title"] rangeOfString:@"电话"].location != NSNotFound) {
                cell.flagIma.hidden=NO;
                
            }
            else
            {
                cell.flagIma.hidden=YES;
            }
            return cell;
        }else{
         
            UBNBLookMerchant_ReportMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:UBNBLookMerchant_ReportMerchantCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = 0;
            cell.type = (self.shopInfoHelper.shopInfos.count == indexPath.row - 1) ? 1 : 0;
            cell.leftTitleLab.text = self.shopInfoHelper.lookAndReports[indexPath.row - self.shopInfoHelper.shopInfos.count];
            
            return cell;
        }
        
    }else{ //附近的商家
       
        SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section - 3];
        if (indexPath.row == 0) {
           
                UBNearByShopCell * cell = [tableView dequeueReusableCellWithIdentifier:UBNearByShopCellIdentifier forIndexPath:indexPath];
                cell.nearByStoreModel = model;
                cell.selectionStyle = 0;
                return cell;
           
           
        }else{
            UBNearByShopDiscountTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:UBNearByShopDiscountTicketCellIdentifier forIndexPath:indexPath];
            SOffLineNearbyStoreListModel * ticketModel = model.ticket[indexPath.row - 1];
            if (model.user_id>0&&model.show_type ==1) {
                
                cell.discountTicketTipLabel.hidden=NO;
                cell.aviliableDiscountTicketLabel.hidden=NO;
                cell.showMoreDiscountTicketBtn.hidden=NO;
            }
            else
            {
                cell.discountTicketTipLabel.hidden=YES;
                cell.aviliableDiscountTicketLabel.hidden=YES;
                cell.showMoreDiscountTicketBtn.hidden=YES;
            }
            cell.nearByStoreTikcetModel = ticketModel;
            cell.ShowMoreDiscountTicketBlock = ^(BOOL isCLick){
                model.RowCount = isCLick?model.ticket.count + 1:2;
                ticketModel.isClick = isCLick;
                [tableView reloadData];
            };
            return cell;
        }
        
    }
    
    return [UITableViewCell new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section < 4) {
        if(section == 1 && !SWNOTEmptyArr(self.comments)){
            return nil;
        }
        
        UBNBSectionHeaderView *headerView = [UBNBSectionHeaderView instanceWithXIB];
        NSString *shopComment = [NSString stringWithFormat:@"店铺评价(%@条)",self.shopDetailModel.commentCount];
        NSString *zongHePingFen = [NSString stringWithFormat:@"综合评分 %@",self.shopDetailModel.commentStar_cate];
        NSArray *leftTitles = @[@"店铺环境",shopComment,@"店铺信息",@"附近的商家"];
        NSArray *rightTitles = @[@"",zongHePingFen,@"",@""];
        [headerView settingLefetTitle:leftTitles[section] rightTitle:rightTitles[section]];
        headerView.frame = CGRectMake(0, 0, ScreenW, [UBNBSectionHeaderView viewHeight]);
        if (section == 1) {
            [headerView discribeTextSettingWithText:zongHePingFen
                                        replaceText:self.shopDetailModel.commentStar_cate];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(tapAction)];
            [headerView addGestureRecognizer:tap];
        }
        return headerView;
    }
    return nil;
}

- (void)tapAction{
//    SEva *evaVC = [[SEva alloc] init];
//    evaVC.type = YES;
//    evaVC.merchant_id = self.merchant_id;
//    [self.tableView.N];
   
    if (self.VCGenerator) {
        self.VCGenerator(@{});
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1 && !SWNOTEmptyArr(self.comments)){
        return .01;
    }
    return section < 4 ? [UBNBSectionHeaderView viewHeight] : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        float screenW=ScreenW - 30;
        return screenW *618 / 1000 + 20;
    }
    if (indexPath.section>3) {
        if (indexPath.row!=0) {
            SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section - 3];
             if (model.user_id>0&&model.show_type ==1) {
               return UITableViewAutomaticDimension;
            }
            else
            {
                return 0;
            }
        }
    }
      return UITableViewAutomaticDimension;
}

- (void)dealWithCallPhoneWithNumber:(NSString*)phone{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phone];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        }
    } else {
        NSString *callPhone = [NSString stringWithFormat:@"tel:%@",phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController * vc = [UIView getCurrentUIViewController:tableView];
    switch (indexPath.section) {
        case 0:break;
        case 1:{}
            break;
        case 2:
            {
                if (indexPath.row < self.shopInfoHelper.shopInfos.count) {
                    //打电话
                    UBNBShopInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    if ([cell.titleLab.text rangeOfString:@"电话"].location != NSNotFound) {
                         [self dealWithCallPhoneWithNumber:cell.messageLab.text];
                    }
                    return;
                }
                
                if (indexPath.row == self.shopInfoHelper.shopInfos.count + self.shopInfoHelper.lookAndReports.count - 3) { //查看商家资质
                    if (self.shopInfoHelper.user_id <= 0) {
                        return;
                    }
                    SBusinessQualification * bq = [[SBusinessQualification alloc] init];
                    bq.merchant_id = _merchant_id;
                    bq.other_license = self.shopDetailModel.other_license;
                    [vc.navigationController pushViewController:bq animated:YES];
                    
                }else if (indexPath.row == self.shopInfoHelper.shopInfos.count + self.shopInfoHelper.lookAndReports.count - 2){ //举报
                    
                    if (self.shopInfoHelper.user_id <= 0) {
                        return;
                    }
                    
                    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
                        SLand * land = [[SLand alloc] init];
                        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                        land.modalPresent = YES;
                        [vc presentViewController:landNav animated:YES completion:nil];
                        return;
                    }
                    SReportingMerchant * rm = [[SReportingMerchant alloc] init];
                    rm.merchant_id = _merchant_id;
                    rm.isUnderline = YES;
                    [vc.navigationController pushViewController:rm animated:YES];
                }else if (indexPath.row == self.shopInfoHelper.shopInfos.count + self.shopInfoHelper.lookAndReports.count - 1){
                    //开始导航  留个入口
                    [self daoHangBtnClick];
                }
            }
            break;
            
        default:
        {
            if (indexPath.row == 0) {
                SOffLineNearbyStoreListModel * model = self.NearByShopList[indexPath.section - 3];
                
                if ([model.goods_num integerValue] >0 ) {
                    [self WebDetailClickWithSid:model.s_id view:tableView];
            
                }
                else
                {
                    UBShopDetailController *detailVC = [UBShopDetailController instanceWithMerchant_id:model.s_id];
                  
                    [vc.navigationController pushViewController:detailVC animated:YES];
                }

            }
        }
            break;
    }
}
- (void)WebDetailClickWithSid:(NSString *)sid view:(UIView *)tableView {
  UIViewController * vc = [UIView getCurrentUIViewController:tableView];
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [vc presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
        };
        return;
    }
    else
    {
        NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
        if (invite_code.length==0) {
            invite_code=@"";
        }
        
        NSString * detail_Base_url =[NSString stringWithFormat:@"http://%@.wujiemall.com/Wap/OfflineStore/offlineShop/os_type/1", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        
        NSString *urlStr=nil;
        
        if (invite_code.length>0) {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@/invite_code/%@.html",detail_Base_url,sid,invite_code];
        }
        else
        {
            urlStr =[NSString stringWithFormat:@"%@/merchant_id/%@.html",detail_Base_url,sid];
        }
        
        
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.urlStr=urlStr;
        conter.fag=@"3";
        conter.hidesBottomBarWhenPushed=YES;
        
        [vc.navigationController pushViewController:conter animated:YES];
    }
}

- (void)daoHangBtnClick{
    /*
     高德 百度 系统自带的地图   没有该地图的不显示
     */
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        _isInstallGaoDeMap = YES;
    } else {
        _isInstallGaoDeMap = NO;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        _isInstallBaiDuMap = YES;
    } else {
        _isInstallBaiDuMap = NO;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]) {
        _isInstallSystomMap = YES;
    } else {
        _isInstallSystomMap = NO;
    }
    
    [self chaXunMapAppMethod];
}

- (void)chaXunMapAppMethod{
    UIViewController * vc = [UIView getCurrentUIViewController:_tableView];
    NSMutableArray *installMaps = [NSMutableArray array];
    
    if (_isInstallGaoDeMap) {
        [installMaps addObject:@"高德地图"];
    }
    
    if(_isInstallBaiDuMap){
        [installMaps addObject:@"百度地图"];
    }
    
    if(_isInstallSystomMap){
        [installMaps addObject:@"系统地图"];
    }
    
    HSQActionSheet *actionSheet = [HSQActionSheet actionSheetWithTitle:nil
                                                              confirms:installMaps
                                                                cancel:@"取消"
                                                                 style:HSQActionSheetStyleDefault];
    actionSheet.delegate = self;
    [actionSheet showInView:vc.view.window];
}

#pragma mark - 点击导航进入各个地图
- (void)clickAction:(HSQActionSheet *)actionSheet atIndex:(NSUInteger)index{
    if (index == 0) {
        if (_isInstallGaoDeMap) {
            [self openGaoDeMap];
        }else if (_isInstallBaiDuMap){
            [self openBaiDuMap];
        }else if(_isInstallSystomMap){
            [self openSystomMap];
        }
        
    }else if (index == 1){
        if (_isInstallBaiDuMap){
            [self openBaiDuMap];
        }else if(_isInstallSystomMap){
            [self openSystomMap];
        }
    }else if(index == 2){
        if(_isInstallSystomMap){
            [self openSystomMap];
        }
    }
}

- (void)openBaiDuMap{
    NSString *baiduParameterFormat = @"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=driving";
    NSString *urlString = [NSString stringWithFormat:baiduParameterFormat,0,0,self.shopDetailModel.lat,self.shopDetailModel.lng,self.shopDetailModel.final_address];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    
}

- (void)openGaoDeMap{  //驾车 骑车
    
    NSString *urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=wujie&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=0",self.shopDetailModel.gaode_lat,self.shopDetailModel.gaode_lng,self.shopDetailModel.final_address];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *myLocationScheme = [NSURL URLWithString:urlString];
        //iOS10以后,使用新API
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:myLocationScheme options:@{ } completionHandler:^(BOOL success) {  }];
        }    else {
            //iOS10以前,使用旧API
            [[UIApplication sharedApplication] openURL:myLocationScheme];
        }
}

- (void)openSystomMap{
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.shopDetailModel.lat,self.shopDetailModel.lng) addressDictionary:nil]]; //目的地坐标
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:NO]}];
    
}

#pragma mark - Interface
//-(void)fetchDataWihtCompletionHandler:(CompletionHandler)completionHandler{
//     MJWeakSelf;
//    [MBProgressHUD showMessage:@"" toView:weakSelf.tableView];
//
//    [HttpManager postWithUrl:kOfflineStore_offlineStoreInfo
//               andParameters:@{@"merchant_id":weakSelf.merchant_id}
//                  andSuccess:^(id Json) {
//                      [MBProgressHUD hideHUDForView:weakSelf.tableView animated:YES];
//                      if (SWNOTEmptyDictionary(Json)) {
//                          if ([Json[@"code"] isEqualToString:@"1"]) {
//                              [weakSelf reloadDataWithDatas:Json[@"data"]];
//                          }else{//失败处理
//                              [MBProgressHUD showSuccess:Json[@"message"] toView:weakSelf.tableView];
//                          }
//                          !completionHandler ?: completionHandler(Json);
//                      }
//                  }
//                     andFail:^(NSError *error) {
//                         [MBProgressHUD hideHUDForView:weakSelf.tableView animated:YES];
//                     }];
//
//    [weakSelf GetNearByMerchantList];
//
//}

- (void)fetchDataWihtPara:(NSDictionary *)para completionHandler:(CompletionHandler)completionHandler{
    MJWeakSelf;
    NSMutableDictionary *paras = nil;
    if (SWNOTEmptyDictionary(para)) {
        paras = para.copy;
    }else{
        paras = [NSMutableDictionary dictionary];
        [paras setValue:weakSelf.merchant_id forKey:@"merchant_id"];
        
        //偷个懒 这个方法自己用
        [weakSelf GetNearByMerchantList];
    }
    [HttpManager postWithUrl:kOfflineStore_offlineStoreInfo
               andParameters:paras
                  andSuccess:^(id Json) {
                      [MBProgressHUD hideHUDForView:weakSelf.tableView.superview animated:YES];
                      if (SWNOTEmptyDictionary(Json)) {
                          if ([Json[@"code"] isEqualToString:@"1"]) {
                              self.shopDetailModel = [UBShopDetailModel mj_objectWithKeyValues:Json[@"data"]];
                              [weakSelf reloadDataWithDatas:self.shopDetailModel];
                    
                          }else{//失败处理
                              [MBProgressHUD showSuccess:Json[@"message"] toView:weakSelf.tableView];
                          }
                          !completionHandler ?: completionHandler(self.shopDetailModel);
                      }
                  }
                     andFail:^(NSError *error) {
                         [MBProgressHUD hideHUDForView:weakSelf.tableView.superview animated:YES];
                     }];
}


-(void)GetNearByMerchantList{
    SOffLineNearbyStoreListModel * store = [[SOffLineNearbyStoreListModel alloc] init];
    store.lng = GET_LNG;
    store.lat = GET_LAT;
    store.p = @"1";
    store.merchant_id = self.merchant_id;
    [store sOfflineStoreOfflineStoreListSuccess:^(NSString *code, NSString *message, id data,id topList) {
        if ([code isEqualToString:@"1"]) {
            [self.NearByShopList removeAllObjects];
            self.NearByShopList = nil;
            self.NearByShopList = [(NSArray *)data mutableCopy];
        }
        [self.tableView reloadData];
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.tableView];
    }];
    
}

- (void)reloadDataWithDatas:(UBShopDetailModel *)data{
    
    for (int i = 0; i < data.commentList.count; i++) {
        UBShopDetailCommentModel *commentModel =  data.commentList[i];
        UBNBCommentCellHelper *commentCellHelper = [UBNBCommentCellHelper helperWithModel:commentModel];
        [self.comments addObject:commentCellHelper];
    }
    
    self.shopInfoHelper = [UBNBShopInfoCellHelper helperWithModel:data];
    [self.tableView reloadData];
}


- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index{
    NSLog(@"--%@--",@(index));
}

-(NSMutableArray *)comments{
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}





@end
