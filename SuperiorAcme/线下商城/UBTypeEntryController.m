//
//  UBTypeEntryController.m
//  SuperiorAcme
//
//  Created by fxg on 2018/8/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UBTypeEntryController.h"

#import "SOnlineShop_seachView.h"
#import "SSearch.h"
#import "SMessage.h"
#import "UBTypePopUpView.h"  //弹出层
#import "SAAPIHelper.h"
#import "UBShopDetailController.h"
#import "SlineDetailWebController.h"
@interface UBTypeEntryController ()

//@property (nonatomic, copy) NSString *top_cate;
@property (nonatomic, strong) UBTypeModel *typeModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UBTypeEntryTableHelper *tableHelper;
@property (nonatomic, strong) UBTypePopUpView *aPopUpView;
@property (nonatomic, strong)  SAAPIHelper *apiHelper;

@end

@implementation UBTypeEntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createNav];
    [self subViewSetting];
    adjustsScrollViewInsets_NO(_tableView, self);
}

- (void)subViewSetting{
   _tableHelper = [UBTypeEntryTableHelper instanceWithTypeModel:self.typeModel
                                                    tableView:self.tableView];
    MJWeakSelf;
    [MBProgressHUD showMessage:@"" toView:self.view];
    // weakSelf.tableHelper.little_cate=nil;
    [_tableHelper fetchDataWithTop_cate:_typeModel.rec_type_id
                            little_cate:nil
                               Complete:^(BOOL isSuccess, NSString *message, id result) {
                              [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                               }];
    
     self.apiHelper = [SAAPIHelper new];
    
    _tableHelper.popUpViewBlock = ^(UBTypeModel *typeModel) { //弹出视图
        [weakSelf showPopViewFirstLevelDataWithData:typeModel];
    };
    
    _tableHelper.didSelectRowBlock = ^(SOffLineNearbyStoreListModel *model) {
        
        if ([model.goods_num integerValue] >0 ) {

            [weakSelf WebDetailClickWithSid:model.s_id];
            
            
        }
        else
        {
            UBShopDetailController *shopDetailVC = [UBShopDetailController instanceWithMerchant_id:model.s_id];
            [weakSelf.navigationController pushViewController:shopDetailVC animated:YES];
        }
        
    };
    
}
- (void)WebDetailClickWithSid:(NSString *)sid {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
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
        
        [self.navigationController pushViewController:conter animated:YES];
    }
}
-(void)showSecondLevelData:(UBTypeModel *)typeModel{
     [MBProgressHUD showMessage:@"" toView:_aPopUpView];
    MJWeakSelf;
    // weakSelf.tableHelper.little_cate=nil;
    [weakSelf.apiHelper refreshOfflineStore_offlineStoreList_lng:GET_LNG
                                                             lat:GET_LAT
                                                     merchant_id:nil
                                                        top_cate:typeModel.rec_type_id
                                                     little_cate:nil
                                                      completion:^(BOOL isSuccess, NSString *message, id result) {
                                                      [MBProgressHUD hideAllHUDsForView:weakSelf.aPopUpView animated:YES];
                                                          if (isSuccess) {
                                                              weakSelf.aPopUpView.typeModel = typeModel;
                                                              weakSelf.aPopUpView.secondLevelDatas = result;
                                                          }else{
                                                               weakSelf.aPopUpView.typeModel = typeModel;
                                                              weakSelf.aPopUpView.secondLevelDatas = nil;
//                                                              [MBProgressHUD showSuccess:message
//                                                                                  toView:weakSelf.aPopUpView];
                                                          }
                                                      }];
}

- (void)showPopViewFirstLevelDataWithData:(UBTypeModel *)typeModel{
    [MBProgressHUD showMessage:@"" toView:self.view];
    MJWeakSelf;
    [SAAPIHelper recommending_businessType_completion:^(BOOL isSuccess, NSString *message, id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if (isSuccess) {
            UBTypePopUpView *aView = [UBTypePopUpView instanceWithXIB];
            aView.frame = self.view.window.bounds;
            [self.view.window addSubview:weakSelf.aPopUpView = aView];
            _aPopUpView.firstLevelDidSelectRowBlcok = ^(UBTypeModel *typeModel) {
                [weakSelf showSecondLevelData:typeModel]; //调取二级数据
            };
            _aPopUpView.popViewClickBlock = ^(UBTypeModel *firstLevelModel, UBTypeModel *secondLevelModel,NSInteger index) {
                [MBProgressHUD showMessage:@"" toView:weakSelf.aPopUpView];
                weakSelf.tableHelper.typeModel = firstLevelModel;
                weakSelf.tableHelper.segSelectIndex = index;
                 weakSelf.tableHelper.little_cate=secondLevelModel.rec_type_id;
                [weakSelf.tableHelper fetchDataWithTop_cate:firstLevelModel.rec_type_id
                                        little_cate:secondLevelModel.rec_type_id
                                           Complete:^(BOOL isSuccess, NSString *message, id result) {
                                               [MBProgressHUD hideAllHUDsForView:weakSelf.aPopUpView animated:YES];
                                           }];
            };
            aView.typeModel = typeModel;
            aView.firstLevelDatas = result;
        }
    }];
}



#pragma mark - 搜索
- (void)searchBtnClick{
//    [mess_count removeFromSuperview];
    
    SSearch * search = [[SSearch alloc] init];
    search.searchType = SearchType_underline;
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - 消息
- (void)rightBtnClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            //            [self showModel];
        };
        return;
    }
//    [mess_count removeFromSuperview];
    SMessage * mess = [[SMessage alloc] init];
    mess.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mess animated:YES];
}

- (void)createNav{
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0,0,-15);
    [rightBtn setImage:[UIImage imageNamed:@"导航栏消息"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[rightBtnItem];
    
    SOnlineShop_seachView * searchView = [[SOnlineShop_seachView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 30)];
    self.navigationItem.titleView = searchView;
    searchView.backgroundColor = [UIColor clearColor];
    searchView.groundView.layer.masksToBounds = YES;
    searchView.groundView.layer.cornerRadius = 3;
    [searchView.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)lefthBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:1]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
}

+ (instancetype)instanceWithTypeModel:(UBTypeModel *)typeModel{
    return [[[self class] alloc] initWithTypeModel:typeModel];
}

-(instancetype)initWithTypeModel:(UBTypeModel *)typeModel{
    if (self = [super init]) {
        self.typeModel = typeModel;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
