//
//  SOnlineShop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//
#define NAVBAR_CHANGE_POINT 50
#define KAPP_id  @"1342931428"

#import "SOnlineShop.h"
#import "SOnlineShop_seachView.h"
#import "SOnlineShop_top.h"
#import "SOnlineShop_header.h"
#import "SNBannerView.h"
#import "SOnlineShop_ClassView.h"
#import "SOnlineShopCell.h"
#import "SOnlineShopCell_2.h"
#import "SOnlineShop_hotgoodsCell.h"

#import "CheckAPPHelper.h"

#import "SPersonalData.h"//个人资料
#import "SOnlineShop_ClassInfoList.h"//分类sub
#import "SSearch.h"//搜索
#import "SScanCode.h"//二维码
#import "SOnlineShop_ClassInfoList_more.h"//分类
#import "SMessage.h"//消息
#import "SLimited.h"//限量购
#import "STicketFight.h"//票券区、拼团区
#import "SThemeStreet.h"//主题街
#import "SSuperPreOrder.h"//无界预购
#import "SEntranceHall.h"//进口馆
#import "SAuctionCollection.h"//竞拍汇
#import "SCarShop.h"//汽车购
#import "SBuildShop.h"//房产购
#import "SIndiana.h"//积分抽奖
#import "SGoodsInfor.h"//商品详情
#import "SHeadlines.h"//无界头条
#import "SWelfareAgency.h"//福利社
#import "SListedIncubation.h"//上市孵化
#import "SLotInfor.h"//竞拍汇详情
#import "SHouseInfor.h"//汽车购详情
#import "SIndianaInfor.h"//积分抽奖详情

#import "SGoodsInfor_first.h"//二期普通商品、票券 详情
#import "SFightGroups.h"//参团

#import "SIndexIndex.h"
//倒计时
#import "OYCountDownManager.h"
#import "GYChangeTextView.h"

#import "SOnlineShopInfor.h"//广告商家跳转
#import "SMessageInfor.h"//广告链接跳转
#import "SUserUserCenter.h"//判断登录是否失效，如果失效清除原先账号信息
#import "SgiftList.h"
#import "CompleteUserView.h"
#import <JPUSHService.h>
#import "CatchTabBarController.h"

#import "GetShengqiangouList.h"
#import "GetShengqiangouListCell.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "SlineDetailWebController.h"
#import "SOrderCenter_list.h"
#import "SlineWebPrint.h"
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

@interface SOnlineShop () <UICollectionViewDelegate,UICollectionViewDataSource,SNBannerViewDelegate,GYChangeTextViewDelegate,BMKLocationServiceDelegate,EMChatManagerDelegate,MTConfirmDeliveredViewDelegate>
{
    UIButton * leftWinBtn;
    UIButton * rightWinBtn;
    UIWindow * coverWindow;//顶部starbar监听
    UIButton * rightBtn_sub;//消息
    SOnlineShop_seachView * searchView;//搜索View
    SOnlineShop_top * top;//Top
    
    SOnlineShop_ClassView * classView;
    NSMutableArray * mutableArr;
    GYChangeTextView * tView;
    
    NSArray * bannerArr;
    NSArray * picture_three_merchant_id;
    NSArray * picture_three_goods_id;
    NSArray * picture_three_href;
    NSArray * picture_arr;
    NSArray * picture_Arr_merchant_id;
    NSArray * picture_Arr_goods_id;
    NSArray * picture_Arr_href;
    
    NSArray * limit_buy_arr;//限量购
    NSArray * ticket_buy_arr;//票券区
    NSArray * pre_buy_arr;//无界预购
    NSArray * country_arr;//进口馆
    NSArray * auction_arr;//竞拍汇
    NSArray * one_buy_arr;//积分抽奖
    NSArray * car_arr;//汽车购
    NSArray * house_arr;//房产购
    NSArray * group_buy_arr;//拼团购
    
    NSArray * hot_goods_arr;//爆款专区
    NSArray *shengqian_arr;
    UILabel * mess_count;//角标个数
    
    NSString * model_lng;//经度
    NSString * model_lat;//纬度
    BMKLocationService * _locService;
    
    //判断活动模块是否开启
    NSString * activity_status;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *mCollection;
@property (strong, nonatomic) IBOutlet UIButton *moveTopBtn;
/*
 *添加当前获取的地址是否可用的状态属性
 */
@property (nonatomic, assign) BOOL LocationAvailable;

/*
 *添加判断是否允许keyWindow添加mess_count的状态属性
 */
@property (nonatomic, assign) BOOL isAddMess_count;

@property (nonatomic, copy) NSString *bestHigherVersion;

@end

@implementation SOnlineShop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.www.wujiemall.com"];
    [userDefaults setValue:Url_header forKey:@"Url_header"];
    
    /*
     *初始化地址是否可用的默认状态
     */
    _LocationAvailable = YES;
    
    [self createNav];
    [self createUI];
    
    //Token
    NSLog(@"token:%@",[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token);
    //User_id
    NSLog(@"user_id:%@",[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].user_id);
    
//    NSMutableSet * tags = [[NSMutableSet alloc] init];
//    [tags addObjectsFromArray:[NSArray arrayWithObjects:@"4000", nil]];
//    [JPUSHService addTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//    } seq:nil];
    
    // 启动倒计时管理
    [kCountDownManager start];
    
    //首次进入App初始化经纬度
    model_lng = @"";
    model_lat = @"";
    
    //判断是否显示活动
    [HttpManager checkTheUpdate:@"1342931428" responseResult:^(NSString * c1, NSString *c2, BOOL c3) {
        if ([self isNO:c1]) {
            activity_status = @"1";
        }else{
            activity_status = @"0";
        }
        
        if (c3) { //用户版本 < appStore 进入
            self.bestHigherVersion = c1;
            [HttpManager postWithUrl:@"version/getVersion"
                       andParameters:@{@"version":[HttpManager infoPlistVersion],@"platform":@"iOS"}
                          andSuccess:^(id Json) {
                              if (SWNOTEmptyDictionary(Json)) {
                                  
                                  NSString *update_forced_state = [NSString stringWithFormat:@"%@",Json[@"data"][@"update_forced_state"]];
                                  if ([update_forced_state isEqualToString:@"2"]) { //可以取消
                                      [self appIsNeedUpdate:@[@"取消",@"更新"] type:MTConfirmDeliveredViewType_NormalGengXin];
                                  }else if ([update_forced_state isEqualToString:@"3"]){ //强制更新
                                      [self appIsNeedUpdate:@[@"更新"] type:MTConfirmDeliveredViewType_QiangZhiGengXin];
                                  }
                              }
                          }
                             andFail:^(NSError *error) {
                                 
                             }];
            
        }
        
    }];
    //推送 收到消息
   
    
}
#pragma mark - APP强制更新
- (void)appIsNeedUpdate:(NSArray *)titles type:(MTConfirmDeliveredViewType)type
{
    NSString *title = @"更新提示";
    NSString *content = [NSString stringWithFormat:@"APP有新的版本需要更新 %@",self.bestHigherVersion];
    MTConfirmDeliveredView *updateView = [[MTConfirmDeliveredView alloc] initWithTitle:title
                                          
                                                                               content:content
                                                                             btnTitles:titles
                                                                                  type:type];
    
    [[UIApplication sharedApplication].keyWindow addSubview:updateView];
    updateView.delegate = self;
    [updateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [updateView viewShow];
}

//强制更新
- (void)qiangZhiGengXinMethod{
    NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@?mt=8",KAPP_id];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL]];
}
//更新
- (void)gengxinMethod{
    NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@?mt=8",KAPP_id];//1242806582
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL]];
}
//取消
- (void)quXiaoGengxinMethod{}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     *当当前控制器的视图将要显示的时候,允许keyWindow添加mess_count
     */
    _isAddMess_count = YES;
    
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mCollection, self);
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//设置系统时间颜色为亮白
    //tabBar-->重置、防止重影
    for (id obj in self.tabBarController.tabBar.subviews) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj removeFromSuperview];
        }
    }
    [self scrollViewDidScroll:_mCollection];
    [TopWindow show];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
    //判断定位是否开启
    if ([CLLocationManager locationServicesEnabled])
    {
        [self initRefresh];
        [self showModel];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    
    /*
     * 修复点击更多按钮后,窗口无内容显示的问题(是因为keyWindow被修改的原因)
     * 重新设置应用的keyWindow
     */
    if (![UIApplication sharedApplication].windows.firstObject.keyWindow) {
        [[UIApplication sharedApplication].windows.firstObject makeKeyWindow];
    }
    
    //开始侧滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //判断侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    leftWinBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, NavigationBarTitleViewMargin, 44)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:leftWinBtn];
    [leftWinBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightWinBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - NavigationBarTitleViewMargin, 20, NavigationBarTitleViewMargin, 44)];
    [[[UIApplication sharedApplication] keyWindow] addSubview:rightWinBtn];
    [rightWinBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mess_count removeFromSuperview];
    //获取当前未读消息数
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = @"";
    list.lat = @"";
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        
        SIndexIndex * list = (SIndexIndex *)data;
        NSLog(@"WWW___________- %@",list.data.return_ticket);
        //判断登录是否失效，如果失效清除原先账号信息
        SUserUserCenter * center = [[SUserUserCenter alloc] init];
        [center sUserUserCenterSuccess:^(NSString *code, NSString *message, id data) {
            if ([code isEqualToString:@"1"]) {
                
                if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token != nil) {
                    SUserUserCenter * center = (SUserUserCenter *)data;
                    UIViewController * vc = self.tabBarController.viewControllers[3];
                    vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",[center.data.cart_num integerValue]];
                }
                
                //判断是否显示版本更新
               [HttpManager checkTheUpdate:@"1342931428" responseResult:^(NSString * c1, NSString *c2, BOOL c3) {
                   if (c3 == YES && [list.data.auto_update_status integerValue] == 0) {
//                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"版本更新" message:@"请前往AppStore更新版本" preferredStyle:UIAlertControllerStyleAlert];
//                        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1342931428"]];
//                        }]];
//                        [self presentViewController:alertController animated:YES completion:nil];
                    } else{
                        
                        /*
                         *添加当前页不再显示的时候,不再提示设置个人资料信息提示的判断(使用了判断mess_count是否添加的时候的属性值)
                         */
                        if (_isAddMess_count) {
                            //如果已登录、地区参数未完善，提醒完善个人资料信息
                  if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token != nil && [list.data.city_status integerValue] == 0) {
                            CompleteUserView * header = [[CompleteUserView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
                          //  NSLog(@"AAAA %@",list.data.return_ticket);
                               header.money=list.data.return_ticket;
                               header.block = ^{
                                SPersonalData * pd = [[SPersonalData alloc] init];
                                pd.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:pd animated:YES];
                            };
                                [self.view.window addSubview:header];
                            
                                
//                                NSString *str=@"请完善个人资料";
//                                if (list.data.return_ticket!=nil) {
//                                    str=[NSString stringWithFormat:@"请完善个人资料,获取%@代金券!",list.data.return_ticket];
//                                }
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
//                                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                                }]];
//                                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                                    NSLog(@"点击确定");
//                                    SPersonalData * pd = [[SPersonalData alloc] init];
//                                    pd.hidesBottomBarWhenPushed = YES;
//                                    [self.navigationController pushViewController:pd animated:YES];
//                                }]];
//                                [self presentViewController:alertController animated:YES completion:nil];
                         }
                     }
                        
                    }
                   
               }];
                
            } else {
                [[SRegisterLogin shareInstance] deleteUserInfo];
                [[EMClient sharedClient] logout:YES];
            }
        } andFailure:^(NSError *error) {
            [[SRegisterLogin shareInstance] deleteUserInfo];
            [[EMClient sharedClient] logout:YES];
        }];
        
        
        [[EMClient sharedClient].chatManager getConversation:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account type:EMConversationTypeChat createIfNotExist:YES];
        [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
        
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSInteger totalUnreadCount = 0;
        for (EMConversation *conversation in conversations) {
            totalUnreadCount += conversation.unreadMessagesCount;
        }
        [mess_count removeFromSuperview];
        
        /*//旧代码
         if ([list.data.msg_tip integerValue] != 0  || totalUnreadCount != 0) {
         if (ScreenW > 375) {
         mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
         } else {
         mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25, STATUS_BAR_HEIGHT, 15, 15)];
         }
         
         
         mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
         mess_count.font = [UIFont systemFontOfSize:10];
         mess_count.textColor = [UIColor whiteColor];
         mess_count.backgroundColor = [UIColor orangeColor];
         mess_count.textAlignment = NSTextAlignmentCenter;
         mess_count.layer.masksToBounds = YES;
         mess_count.layer.cornerRadius = 7.5;
         [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
         
         }
         */
        
        /*
         *根据"_isAddMess_count"的状态,来判断是否允许keyWindow添加mess_count
         */
        if (_isAddMess_count) {
            if ([list.data.msg_tip integerValue] != 0  || totalUnreadCount != 0) {
                if (ScreenW > 375) {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35, STATUS_BAR_HEIGHT, 15, 15)];
                } else {
                    mess_count = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 25, STATUS_BAR_HEIGHT, 15, 15)];
                }
                
                
                mess_count.text = [NSString stringWithFormat:@"%ld",[list.data.msg_tip integerValue] + totalUnreadCount];
                mess_count.font = [UIFont systemFontOfSize:10];
                mess_count.textColor = [UIColor whiteColor];
                mess_count.backgroundColor = [UIColor orangeColor];
                mess_count.textAlignment = NSTextAlignmentCenter;
                mess_count.layer.masksToBounds = YES;
                mess_count.layer.cornerRadius = 7.5;
                [[[UIApplication sharedApplication] keyWindow] addSubview:mess_count];
                
            }
        }
        
        
    } andFailure:^(NSError *error) {
    }];
}
- (void)messagesDidReceive:(NSArray *)aMessages {
    if ([NSStringFromClass([self.navigationController.viewControllers.lastObject class]) isEqualToString:@"SOnlineShop"]) {
        [self viewDidAppear:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
     *当当前控制器的视图将要"不显示"的时候,不允许keyWindow添加mess_count
     */
    _isAddMess_count = NO;
    
    [self.navigationController.navigationBar lt_reset];
    [coverWindow removeFromSuperview];
    
    [mess_count removeFromSuperview];
    [leftWinBtn removeFromSuperview];
    [rightWinBtn removeFromSuperview];
    
    _locService.delegate = nil; // 不用时，置nil
    
    [tView stopAnimation];//停止无界头条文字动画的滚动
}

#pragma mark - 获取用户当前位置相关
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //    if ([model_lng isEqualToString:@""]) {//旧代码
    /*
     *添加当前地址是否可用的判断
     *只有当经度值不为@""且同时当前地址可用即_LocationAvailable==YES时,才不用再进行经纬度反编译
     */
    if ([model_lng isEqualToString:@""] || _LocationAvailable == NO) {
        model_lng = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.longitude];
        model_lat = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.latitude];
        
        /*
         *将获取的经纬度保存到本地
         */
        [[NSUserDefaults standardUserDefaults] setObject:model_lng forKey:@"lng"];//保存经度
        [[NSUserDefaults standardUserDefaults] setObject:model_lat forKey:@"lat"];//保存纬度
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        //模拟别的城市
        //        CLLocation *location = [[CLLocation alloc] initWithLatitude:31.6529795557 longitude:105.4670763016];
        
        [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
            if (array.count > 0) {
                
                /*
                 *恢复当前地址可用的状态为YES;
                 */
                _LocationAvailable = YES;
                
                CLPlacemark *placemark = [array objectAtIndex:0];
                if (placemark != nil) {
                    NSString *country = placemark.administrativeArea == nil ? [placemark.locality substringToIndex:2] : placemark.administrativeArea;
                    NSString *city = placemark.locality;
                    NSString *city_sub = placemark.subLocality;
                    
                    //                    NSLog(@"获取的内容 %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@  %@",placemark.name,placemark.thoroughfare,placemark.subThoroughfare,placemark.locality,placemark.subLocality,placemark.administrativeArea == nil ? [placemark.locality substringToIndex:2] : placemark.administrativeArea,placemark.subAdministrativeArea,placemark.postalCode,placemark.ISOcountryCode,placemark.country,placemark.country,placemark.inlandWater,placemark.ocean,placemark.areasOfInterest);
                    
                    [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"当前国家名称"];
                    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"当前城市名称"];
                    [[NSUserDefaults standardUserDefaults] setObject:city_sub forKey:@"当前城市名称_sub"];
                    
                    //                    BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                    ////                    _offlineMap.delegate = self;//可以不要
                    //                    NSArray* records = [_offlineMap searchCity:city];
                    //                    BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                    //                    //城市编码如:北京为131
                    //                    NSInteger cityId = oneRecord.cityID;
                    //
                    //                    NSLog(@"当前城市编号-------->%zd",cityId);
                    //找到了当前位置城市后就关闭服务
                    [_locService stopUserLocationService];
                }
            }
            /*
             *添加获取的经纬度反编译后无地址信息的显示
             */
            else{
                /*
                 *如果当前位置信息不可用的时候,显示默认的地址信息
                 */
                [self didFailToLocateUserWithError:nil];
                /*
                 *回复当前地址信息不可用的状态为默认的NO
                 */
                _LocationAvailable = NO;
            }
        }];
        
        //加载数据
        [self initRefresh];
        [self showModel];
    } else {
        //如果定位了直接获取，无需再次定位
        model_lng = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.longitude];
        model_lat = [NSString stringWithFormat:@"%.6f",userLocation.location.coordinate.latitude];
        
        /*
         *将获取的经纬度保存到本地
         */
        [[NSUserDefaults standardUserDefaults] setObject:model_lng forKey:@"lng"];//保存经度
        [[NSUserDefaults standardUserDefaults] setObject:model_lat forKey:@"lat"];//保存纬度
    }
}

/**
 *定位失败后，会调用此函数(不允许开启定位也会调用此方法)
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error{
    
    //当用户没有允许自动获取地址,或者获取地址失败后,设置默认地址为北京
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前国家名称"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"北京市" forKey:@"当前国家名称"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前城市名称"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"北京市" forKey:@"当前城市名称"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"当前城市名称_sub"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"东城区" forKey:@"当前城市名称_sub"];
    }
    
    /*
     *将获取的经纬度保存到本地
     */
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"lng"];//保存经度
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"lat"];//保存纬度
    
}

#pragma mark - 初始化下拉刷新
- (void)initRefresh
{
    __block SOnlineShop * blockSelf = self;
    _mCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf showModel];
    }];
}
#pragma mark - 首页数据
- (void)showModel {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    SIndexIndex * list = [[SIndexIndex alloc] init];
    list.lng = model_lng;
    list.lat = model_lat;
    list.page_size=@"20";
    [MBProgressHUD showMessage:@"" toView:self.view];
    [list sIndexIndexSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_mCollection.mj_header endRefreshing];
        
        SIndexIndex * list = (SIndexIndex *)data;
        //首页活动是否开启  0不开启 1开启"
        //        activity_status = list.data.activity_status;
        if ([activity_status integerValue] == 0) {
            /*
            //隐藏活动
            if ([Url_header isEqualToString:@"api"]) {
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW/600*400  + 330 - 200);
                top.btnView.hidden=YES;
                top.btnViewHHH.constant=0;
           
            }
            else
            {
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW/600*400 + ScreenW/600*200 + 330 - 200);
                top.btnView.hidden=NO;
                top.btnViewHHH.constant=138;
            }
             */
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW/600*400  + 330 - 200);
            top.btnView.hidden=YES;
            top.btnViewHHH.constant=0;
            top.actionView.hidden = YES;
            top.actionView_HHH.constant = 0;
            top.header_mImage1.hidden = YES;
            top.header_mImage2.hidden = YES;
            top.imageBtn0.hidden = YES;
            
        } else {
            /*
            //开启活动
            if ([Url_header isEqualToString:@"api"]) {
                top.frame = CGRectMake(0, 0, ScreenW, ScreenW/600*400+ ScreenW/1242*300 + ScreenW/1242*148+330);
                top.btnView.hidden=YES;
                top.btnViewHHH.constant=0;

            }
            else
            {
              top.frame = CGRectMake(0, 0, ScreenW, ScreenW/600*400 + 120 + ScreenW/1242*300 + ScreenW/1242*148 + 330);
              
                top.btnView.hidden=YES;
                top.btnViewHHH.constant=120;
             
            }
            */
            top.frame = CGRectMake(0, 0, ScreenW, ScreenW/600*400+ ScreenW/1242*148+330+100);
            top.btnView.hidden=YES;
            top.btnViewHHH.constant=0;
            top.header_mImage1.hidden = NO;
            top.header1_mImage1HHH.constant=100;
            
            top.header_mImage2.hidden = NO;
            top.imageBtn0.hidden = NO;
            top.actionView.hidden = NO;
            top.actionView_HHH.constant = 200;
        }
        //轮播图
        SNBannerView * banner = [[SNBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW /600*400) delegate:self model:list.data.index_banner URLAttributeName:@"picture" placeholderImageName:@"无界优品默认空视图" currentPageTintColor:[UIColor redColor] pageTintColor:WordColor_sub_sub];
        [top.bannerView addSubview:banner];
        bannerArr = list.data.index_banner;
        //筛选类型：推荐、食品、数码等等
        [classView showModel:list.data.top_nav];
        
        //展示头条轮播
        mutableArr = [NSMutableArray array];
        NSMutableArray * headlinesArr = [[NSMutableArray alloc] init];
        for (SIndexIndex * list_title in list.data.headlines) {
            [headlinesArr addObject:list_title.title];
        }
        [self groupArray:headlinesArr];
        //        NSLog(@"一维转二维:%@",mutableArr);
        NSMutableArray * headlinesArr_over = [[NSMutableArray alloc] init];
        for (int i = 0; i < mutableArr.count; i++) {
            [headlinesArr_over addObject:[mutableArr[i] componentsJoinedByString:@"\n"]];
            
        }
        [tView removeFromSuperview];
        tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 90, 70)];
        tView.delegate = self;
        [top.headerlineView addSubview:tView];
        if (headlinesArr_over.count != 0) {
            [tView animationWithTexts:headlinesArr_over];
        }
        
        //三个小广告
        [top.brandBtn setTag:0];
        [top.brandBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:list.data.three_img.brand.picture] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [top.brandBtn addTarget:self action:@selector(imageBtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.chinaBtn setTag:1];
        [top.chinaBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:list.data.three_img.china.picture] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [top.chinaBtn addTarget:self action:@selector(imageBtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [top.scienceBtn setTag:2];
        [top.scienceBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:list.data.three_img.science.picture] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [top.scienceBtn addTarget:self action:@selector(imageBtnThreeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        picture_three_merchant_id = @[
                                      list.data.three_img.brand.merchant_id == nil ? @"" : list.data.three_img.brand.merchant_id
                                      ,list.data.three_img.china.merchant_id == nil ? @"" : list.data.three_img.china.merchant_id
                                      ,list.data.three_img.science.merchant_id == nil ? @"" : list.data.three_img.science.merchant_id
                                      ];
        picture_three_goods_id = @[
                                   list.data.three_img.brand.goods_id == nil ? @"" : list.data.three_img.brand.goods_id
                                   ,list.data.three_img.china.goods_id == nil ? @"" : list.data.three_img.china.goods_id
                                   ,list.data.three_img.science.goods_id == nil ? @"" : list.data.three_img.science.goods_id
                                   ];
        picture_three_href = @[
                               list.data.three_img.brand.href == nil ? @"" : list.data.three_img.brand.href
                               ,list.data.three_img.china.href == nil ? @"" : list.data.three_img.china.href
                               ,list.data.three_img.science.href == nil ? @"" : list.data.three_img.science.href
                               ];
        //限量购改爆款专区
      //  [top.header_mImage1 sd_setImageWithURL:[NSURL URLWithString:list.data.limit_buy.ads.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        
      //   list.data.limit_buy.ads.href == nil ? @"" : list.data.limit_buy.ads.href
        
     
        [top.header_mImage1 sd_setImageWithURL:[NSURL URLWithString:list.data.shengqiangou.ads.picture] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
       
        //下面每个分类的广告图
        picture_arr = @[ list.data.shengqiangou.ads.picture == nil ? @"" : list.data.shengqiangou.ads.picture,
                        list.data.hot_goods.ads.picture == nil ? @"" : list.data.hot_goods.ads.picture
                        ,list.data.group_buy.ads.picture == nil ? @"" : list.data.group_buy.ads.picture
                        ,list.data.ticket_buy.ads.picture == nil ? @"" : list.data.ticket_buy.ads.picture
                        ,list.data.pre_buy.ads.picture == nil ? @"" : list.data.pre_buy.ads.picture
                        ,list.data.country.ads.picture == nil ? @"" : list.data.country.ads.picture
                        ,list.data.auction.ads.picture == nil ? @"" : list.data.auction.ads.picture
                        ,list.data.one_buy.ads.picture == nil ? @"" : list.data.one_buy.ads.picture
                        ,list.data.car.ads.picture == nil ? @"" : list.data.car.ads.picture
                        ,list.data.house.ads.picture == nil ? @"" : list.data.house.ads.picture
                       
                        ];
        picture_Arr_merchant_id = @[list.data.shengqiangou.ads.merchant_id == nil ? @"" : list.data.shengqiangou.ads.merchant_id,
                                    list.data.hot_goods.ads.merchant_id == nil ? @"" : list.data.hot_goods.ads.merchant_id
                                    ,list.data.group_buy.ads.merchant_id == nil ? @"" : list.data.group_buy.ads.merchant_id
                                    ,list.data.ticket_buy.ads.merchant_id == nil ? @"" : list.data.ticket_buy.ads.merchant_id
                                    ,list.data.pre_buy.ads.merchant_id == nil ? @"" : list.data.pre_buy.ads.merchant_id
                                    ,list.data.country.ads.merchant_id == nil ? @"" : list.data.country.ads.merchant_id
                                    ,list.data.auction.ads.merchant_id == nil ? @"" : list.data.auction.ads.merchant_id
                                    ,list.data.one_buy.ads.merchant_id == nil ? @"" : list.data.one_buy.ads.merchant_id
                                    ,list.data.car.ads.merchant_id == nil ? @"" : list.data.car.ads.merchant_id
                                    ,list.data.house.ads.merchant_id == nil ? @"" : list.data.house.ads.merchant_id
                                    
                                    ];
        picture_Arr_goods_id = @[ list.data.shengqiangou.ads.goods_id == nil ? @"" : list.data.shengqiangou.ads.goods_id,
                                 list.data.hot_goods.ads.goods_id == nil ? @"" : list.data.hot_goods.ads.goods_id
                                 ,list.data.group_buy.ads.goods_id == nil ? @"" : list.data.group_buy.ads.goods_id
                                 ,list.data.ticket_buy.ads.goods_id == nil ? @"" : list.data.ticket_buy.ads.goods_id
                                 ,list.data.pre_buy.ads.goods_id == nil ? @"" : list.data.pre_buy.ads.goods_id
                                 ,list.data.country.ads.goods_id == nil ? @"" : list.data.country.ads.goods_id
                                 ,list.data.auction.ads.goods_id == nil ? @"" : list.data.auction.ads.goods_id
                                 ,list.data.one_buy.ads.goods_id == nil ? @"" : list.data.one_buy.ads.goods_id
                                 ,list.data.car.ads.goods_id == nil ? @"" : list.data.car.ads.goods_id
                                 ,list.data.house.ads.goods_id == nil ? @"" : list.data.house.ads.goods_id
                                
                                 ];
        picture_Arr_href = @[list.data.shengqiangou.ads.href == nil ? @"" : list.data.shengqiangou.ads.href
                             ,
                             list.data.hot_goods.ads.href == nil ? @"" : list.data.hot_goods.ads.href
                             ,list.data.group_buy.ads.href == nil ? @"" : list.data.group_buy.ads.href
                             ,list.data.ticket_buy.ads.href == nil ? @"" : list.data.ticket_buy.ads.href
                             ,list.data.pre_buy.ads.href == nil ? @"" : list.data.pre_buy.ads.href
                             ,list.data.country.ads.href == nil ? @"" : list.data.country.ads.href
                             ,list.data.auction.ads.href == nil ? @"" : list.data.auction.ads.href
                             ,list.data.one_buy.ads.href == nil ? @"" : list.data.one_buy.ads.href
                             ,list.data.car.ads.href == nil ? @"" : list.data.car.ads.href
                             ,list.data.house.ads.href == nil ? @"" : list.data.house.ads.href
                            
                             ];
        
        //限量购
        limit_buy_arr = list.data.limit_buy.goodsList;
        //票券区
        ticket_buy_arr = list.data.ticket_buy.goodsList;
        //无界预购
        pre_buy_arr = list.data.pre_buy.goodsList;
        //进口馆
        country_arr = list.data.country.goodsList;
        //竞拍汇
        auction_arr = list.data.auction.goodsList;
        //积分抽奖
        one_buy_arr = list.data.one_buy.goodsList;
        //汽车购
        car_arr = list.data.car.goodsList;
        //房产购
        house_arr = list.data.house.goodsList;
        //拼团购
        group_buy_arr = list.data.group_buy.goodsList;
        
        hot_goods_arr=list.data.hot_goods.goodsList;
        shengqian_arr=list.data.shengqiangou.goods_list;
        //倒计时
        [kCountDownManager reload];
        [_mCollection reloadData];
        
    } andFailure:^(NSError *error) {
        [_mCollection.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 轮播广告
- (void)bannerView:(SNBannerView *)bannerView didSelectImageIndex:(NSInteger)index {
    SIndexIndex * home = bannerArr[index];
    if (home.merchant_id != nil && ![home.merchant_id isEqualToString:@""] && ![home.merchant_id isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = home.merchant_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (home.goods_id != nil && ![home.goods_id isEqualToString:@""] && ![home.goods_id isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = home.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (home.href != nil && ![home.href isEqualToString:@""] && ![home.href isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = home.href;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    
}
#pragma mark - 三广告活动
- (void)imageBtnThreeClick:(UIButton *)btn {
    if (picture_three_merchant_id[btn.tag] != nil && ![picture_three_merchant_id[btn.tag] isEqualToString:@""] && ![picture_three_merchant_id[btn.tag] isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = picture_three_merchant_id[btn.tag];
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (picture_three_goods_id[btn.tag] != nil && ![picture_three_goods_id[btn.tag] isEqualToString:@""] && ![picture_three_goods_id[btn.tag] isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = picture_three_goods_id[btn.tag];
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (picture_three_href[btn.tag] != nil && ![picture_three_href[btn.tag] isEqualToString:@""] && ![picture_three_href[btn.tag] isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = picture_three_href[btn.tag];
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
}
#pragma mark - 头条文字重排
- (void)groupArray:(NSArray *)arr {
    NSInteger count = 0;
    if (arr.count%2 == 0) {
        count = arr.count/2;
    } else {
        count = (arr.count + 1)/2;
    }
    NSMutableArray *transferArray = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i=0; i<count; i++) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSInteger j=0; j<2; j++) {
            [tmpArray addObject:@""];//补充不足的最后一位
        }
        [transferArray addObject:tmpArray];
    }
    for (NSInteger i=0; i<arr.count; i++) {
        transferArray[i/2][i%2] = arr[i];
    }
    [mutableArr addObjectsFromArray:transferArray];
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    [lefthBtn setImage:[UIImage imageNamed:@"导航栏扫一扫"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-15,0,0);
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn setImage:[UIImage imageNamed:@"导航栏消息"] forState:UIControlStateNormal];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-15);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn_sub.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem * rightBtnItem_sub = [[UIBarButtonItem alloc] initWithCustomView:rightBtn_sub];
    [rightBtn_sub setImage:[UIImage imageNamed:@"导航栏分类"] forState:UIControlStateNormal];
    rightBtn_sub.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-25);
    [rightBtn_sub addTarget:self action:@selector(rightBtn_subClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightBtnItem,rightBtnItem_sub];
    
    
    searchView = [[SOnlineShop_seachView alloc] initWithFrame:CGRectMake(0, 7, ScreenW, 30)];
    self.navigationItem.titleView = searchView;
    searchView.backgroundColor = [UIColor clearColor];
    //    [navigationBarView addSubview:searchView];
    searchView.groundView.layer.masksToBounds = YES;
    searchView.groundView.layer.cornerRadius = 3;
    [searchView.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 搜索
- (void)searchBtnClick{
    [mess_count removeFromSuperview];
    SSearch * search = [[SSearch alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}
#pragma mark - 扫一扫
- (void)lefthBtnClick {
    
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [self showModel];
        };
        return;
    }
    [mess_count removeFromSuperview];
    SScanCode * code = [[SScanCode alloc] init];
    code.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:code animated:YES];
}
#pragma mark - 消息
- (void)rightBtnClick {
    if ([[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].token == nil) {
        SLand * land = [[SLand alloc] init];
        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
        land.modalPresent = YES;
        [self presentViewController:landNav animated:YES completion:nil];
        land.SLand_showModel = ^{
            [self showModel];
        };
        return;
    }
    [mess_count removeFromSuperview];
    SMessage * mess = [[SMessage alloc] init];
    mess.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mess animated:YES];
}
#pragma mark - 分类
- (void)rightBtn_subClick {
    [mess_count removeFromSuperview];
    SOnlineShop_ClassInfoList_more * more = [[SOnlineShop_ClassInfoList_more alloc] init];
    more.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:more animated:YES];
}
- (void)createUI {
    UICollectionViewFlowLayout * mFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    mFlowLayout.minimumInteritemSpacing = 5;//用于控制单元格之间最小 列间距
    mFlowLayout.minimumLineSpacing = 5;//用于控制单元格之间最小 行间距
    _mCollection.collectionViewLayout = mFlowLayout;
    
    //隐藏滚轴
    _mCollection.showsHorizontalScrollIndicator = NO;
    _mCollection.showsVerticalScrollIndicator = NO;
    
    //Header
    [_mCollection registerNib:[UINib nibWithNibName:@"SOnlineShop_header" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SOnlineShop_header"];
    //Cell
    [_mCollection registerNib:[UINib nibWithNibName:@"SOnlineShopCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell"];
    [_mCollection registerNib:[UINib nibWithNibName:@"SOnlineShopCell_2" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShopCell_2"];
    
       [_mCollection registerNib:[UINib nibWithNibName:@"SOnlineShop_hotgoodsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SOnlineShop_hotgoodsCell"];
    
  [_mCollection registerNib:[UINib nibWithNibName:NSStringFromClass([GetShengqiangouListCell class]) bundle:nil] forCellWithReuseIdentifier:@"GetShengqiangouListCell"];
    
 top = [[SOnlineShop_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW/600*400 + ScreenW/600*200 + ScreenW/1242*300 + ScreenW/1242*148 + 330)];
    [_mCollection addSubview:top];
    //限量购
    [top.oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //票券区
    [top.twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //拼团区
    [top.threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //主题街
    [top.fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //无界预购
    [top.fiveBtn addTarget:self action:@selector(fiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
  
    //进口馆
    [top.sexBtn addTarget:self action:@selector(sexBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //竞拍汇
    [top.sevenBtn addTarget:self action:@selector(sevenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //汽车购
    [top.eightBtn addTarget:self action:@selector(eightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //房产购
    [top.nineBtn addTarget:self action:@selector(nineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //积分抽奖
    [top.tenBtn addTarget:self action:@selector(tenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //无界头条
    [top.headlinesBtn addTarget:self action:@selector(headlinesBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //限量购活动
    [top.imageBtn0 addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [top.imageBtn0 setTag:0];
    
    __block SOnlineShop * gSelf = self;
    
    classView = [[SOnlineShop_ClassView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    [top.classView addSubview:classView];
    classView.SOnlineShop_ClassView_choiceType = ^(NSInteger indexPath, NSString *cate_id) {
        [mess_count removeFromSuperview];
        SOnlineShop_ClassInfoList * classInfo = [[SOnlineShop_ClassInfoList alloc] init];
        classInfo.hidesBottomBarWhenPushed = YES;
        classInfo.indexPath = indexPath;
        classInfo.model_cate_id = cate_id;
        [gSelf.navigationController pushViewController:classInfo animated:YES];
    };
    //置顶
    _moveTopBtn.hidden = YES;
    [_moveTopBtn addTarget:self action:@selector(moveTopBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 置顶
- (void)moveTopBtnClick {
    [_mCollection setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark - 限量购 互清库存
- (void)oneBtnClick {
    [mess_count removeFromSuperview];
    if ([Url_header isEqualToString:@"test2"]) {
        STicketFight * fight = [[STicketFight alloc] init];
        fight.hidesBottomBarWhenPushed = YES;
        fight.type = @"11";
        [self.navigationController pushViewController:fight animated:YES];
    }
    else
    {
    
    SLimited * sl = [[SLimited alloc] init];
    sl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sl animated:YES];
    }
   
    
    
}


#pragma mark - 票券区  抓娃娃
- (void)twoBtnClick {
    [mess_count removeFromSuperview];

    if ([Url_header isEqualToString:@"test"]) {
        
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
        CatchTabBarController * tabBarController = [[CatchTabBarController alloc] init];
        [self presentViewController:tabBarController animated:YES completion:nil];
        }
    }
    else
    {
    
    STicketFight * fight = [[STicketFight alloc] init];
    fight.hidesBottomBarWhenPushed = YES;
    fight.type = @"1";
    [self.navigationController pushViewController:fight animated:YES];
    }
  
}
#pragma mark - 拼团购
- (void)threeBtnClick {
    [mess_count removeFromSuperview];
    STicketFight * fight = [[STicketFight alloc] init];
    fight.hidesBottomBarWhenPushed = YES;
    fight.type = @"2";
    [self.navigationController pushViewController:fight animated:YES];
}
#pragma mark - 主题街
- (void)fourBtnClick {
    [mess_count removeFromSuperview];
    SThemeStreet * street = [[SThemeStreet alloc] init];
    street.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:street animated:YES];
}
#pragma mark - 无界预购  改集碎片
- (void)fiveBtnClick {
    //    SSuperPreOrder * pre = [[SSuperPreOrder alloc] init];
    //    pre.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:pre animated:YES];
    
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
        [mess_count removeFromSuperview];
        NSString *    urlStr =[NSString stringWithFormat:@"http://%@.wujiemall.com/Splicing/index/", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.fag=@"9";
        conter.urlStr=urlStr;
  
        conter.hidesBottomBarWhenPushed=YES;
      [self.navigationController pushViewController:conter animated:YES];
    }
    
//            STicketFight * fight = [[STicketFight alloc] init];
//            fight.hidesBottomBarWhenPushed = YES;
//            fight.type = @"4";
//            [self.navigationController pushViewController:fight animated:YES];
}
#pragma mark - 进口馆
- (void)sexBtnClick {
    [mess_count removeFromSuperview];
    SEntranceHall * eh = [[SEntranceHall alloc] init];
    eh.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:eh animated:YES];
}
#pragma mark - 竞拍汇 比价购 改爆款专区
- (void)sevenBtnClick {
    [mess_count removeFromSuperview];
//    SAuctionCollection * aucCollect = [[SAuctionCollection alloc] init];
//    aucCollect.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:aucCollect animated:YES];
    
    STicketFight * fight = [[STicketFight alloc] init];
    fight.type = @"10";
    fight.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fight animated:YES];
}
#pragma mark - 无界商店
- (void)eightBtnClick {
    [mess_count removeFromSuperview];
//    SCarShop * car = [[SCarShop alloc] init];
//    car.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:car animated:YES];
    
    STicketFight * fight = [[STicketFight alloc] init];
    fight.type = @"3";
     fight.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fight animated:YES];
    
}
#pragma mark - 房产购  赠品专区  省钱购
- (void)nineBtnClick {
    [mess_count removeFromSuperview];
   ///SBuildShop * bs = [[SBuildShop alloc] init];
 //   if ([Url_header isEqualToString:@"test3"]) {
        GetShengqiangouList * bs = [[GetShengqiangouList alloc] init];
        bs.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bs animated:YES];
//    }
//    else
//    {
//        SgiftList * bs = [[SgiftList alloc] init];
//        bs.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:bs animated:YES];
//    }

}
#pragma mark - 积分抽奖 改紫薇斗数
- (void)tenBtnClick {
//    [mess_count removeFromSuperview];
//    SIndiana * ind = [[SIndiana alloc] init];
//    ind.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ind animated:YES];
//
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
        [mess_count removeFromSuperview];
       NSString *    urlStr =[NSString stringWithFormat:@"http://%@.wujiemall.com/Divination/Index/index", [Url_header isEqualToString:@"api"] ? @"www" : Url_header];
        SlineDetailWebController *conter=[[SlineDetailWebController alloc]init];
        conter.fag=@"12";
        conter.urlStr=urlStr;
        
        conter.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:conter animated:YES];
   }
    
}
#pragma mark - 无界头条
- (void)headlinesBtnClick {
    [mess_count removeFromSuperview];
    SHeadlines * hea = [[SHeadlines alloc] init];
    hea.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hea animated:YES];
}
#pragma mark 返回值决定UICollectionView包含多少个单元格
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        //  return limit_buy_arr.count;
        return shengqian_arr.count;
    }
    
    if (section == 1) {
      //  return limit_buy_arr.count;
        return hot_goods_arr.count;
    }
    if (section == 2) {
        return group_buy_arr.count;
    }
    if (section == 3) {
        return ticket_buy_arr.count;
    }
    if (section == 4) {
        return pre_buy_arr.count;
    }
    if (section == 5) {
        return country_arr.count;
    }
    if (section == 6) {
        return auction_arr.count;
    }
    if (section == 7) {
        return one_buy_arr.count;
    }
    if (section == 8) {
        return car_arr.count;
    }
    if (section == 9) {
       return house_arr.count;
    }
    return 0;
}
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        if ([activity_status integerValue] == 0) {
            /*
            if ([Url_header isEqualToString:@"api"]) {
                 return UIEdgeInsetsMake(ScreenW/600*400  + 330 - 200, 0, 0, 0);
            }
            else
            {
                return UIEdgeInsetsMake(ScreenW/600*400 + ScreenW/600*200 + 330 - 200, 0, 0, 0);
            }
           */
            return UIEdgeInsetsMake(ScreenW/600*400  + 330 - 200, 0, 0, 0);
        }
        else
        {
            /*
            if ([Url_header isEqualToString:@"api"]) {
              return UIEdgeInsetsMake( ScreenW/600*400+330 + ScreenW/1242*300 + ScreenW/1242*148 , 0, 0, 0);
            }
            else
            {
               return UIEdgeInsetsMake(ScreenW/600*400 + 120  + ScreenW/1242*148 + 330, 0, 0, 0);
            }
             */
             return UIEdgeInsetsMake( ScreenW/600*400+330  +100+ ScreenW/1242*148 , 0, 0, 0);
        }
       
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40);
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 24 + 40 + 15+15 );
    }
    //限量购
    if (indexPath.section == 1) {
    //    return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40);
      return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 24 + 40 + 15+15 );
    }
    //拼单购
    if (indexPath.section == 2) {
        //        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 170 + 40);
        /*
         *隐藏掉单买价后的item的高度
         */
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 150 + 40);
    }
    //票券区
    if (indexPath.section == 3) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    //无界预购
    if (indexPath.section == 4) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 30 + 40);
    }
    //进口馆
    if (indexPath.section == 5) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40);
    }
    //竞拍汇
    if (indexPath.section == 6) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 30 + 40);
    }
    //积分抽奖
    if (indexPath.section == 7) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 30 + 30 + 40 + 40);
    }
    //汽车购
    if (indexPath.section == 8) {
        return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 70 + 30 + 40 + 20);
    }
    //房产购
    if (indexPath.section == 9) {
          return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 40 + 90 + 40 + 20);
    }
       return CGSizeMake(ScreenW/2 - 2.5, ScreenW/2 - 2.5 + 24 + 40 + 15 );
 
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        CGSize size = {0.01,0.01};
        return size;
    }
   else  if ([activity_status integerValue] == 0) {
      
        CGSize size = {0.01,0.01};
        return size;
    }
   else
   {
       if ([Url_header isEqualToString:@"api"]) {
           if( section==3||section==4||section==6||section==7||section==8||section==9) {
               CGSize size = {0.01,0.01};
               return size;
           }
       }
    CGSize size = {0.01,ScreenW/1242*300 + ScreenW/1242*148};
     
       return size;
  }
   
}
#pragma mark 设置 HeadView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ;
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        SOnlineShop_header * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SOnlineShop_header" forIndexPath:indexPath];
    
        [header.headerImage1 sd_setImageWithURL:[NSURL URLWithString:picture_arr[indexPath.section]] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        NSArray * picture_arr_sub = @[@"首页header爆款专区",@"首页header爆款专区",@"首页header拼单购",@"首页header票券区",@"首页header无界预购",@"首页header进口馆",@"首页header比价购",@"首页header积分抽奖",@"首页header汽车沟",@"首页header房产购"];
        header.headerImage2.image = [UIImage imageNamed:picture_arr_sub[indexPath.section]];
        [header.imageBtn setTag:indexPath.section];
        [header.imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if ([activity_status integerValue] == 0) {
            header.headerImage1.hidden = YES;
            header.headerImage2.hidden = YES;
            header.imageBtn.hidden = YES;
        }
        else if ([Url_header isEqualToString:@"api"])
        {
            if (indexPath.section==0||indexPath.section==3||indexPath.section==4||indexPath.section==6||indexPath.section==7||indexPath.section==8||indexPath.section==9) {
                header.headerImage1.hidden = YES;
                header.headerImage2.hidden = YES;
                header.imageBtn.hidden = YES;
            }
            else
            {
                header.headerImage1.hidden = NO;
                header.headerImage2.hidden = NO;
                header.imageBtn.hidden = NO;
            }
        }
        else {
            header.headerImage1.hidden = NO;
            header.headerImage2.hidden = NO;
            header.imageBtn.hidden = NO;
        }
        
    
        reusableview = header;
        
    }// header;
         
    return reusableview;
}
#pragma mark - 广告活动
- (void)imageBtnClick:(UIButton *)btn {
    //    NSLog(@"btn:%ld",(long)btn.tag);
    //    NSLog(@"1:%@",picture_Arr_merchant_id[btn.tag]);
    //    NSLog(@"2:%@",picture_Arr_goods_id[btn.tag]);
    //    NSLog(@"3:%@",picture_Arr_href[btn.tag]);
    if (picture_Arr_merchant_id[btn.tag] != nil && ![picture_Arr_merchant_id[btn.tag] isEqualToString:@""] && ![picture_Arr_merchant_id[btn.tag] isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
        infor.merchant_id = picture_Arr_merchant_id[btn.tag];
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (picture_Arr_goods_id[btn.tag] != nil && ![picture_Arr_goods_id[btn.tag] isEqualToString:@""] && ![picture_Arr_goods_id[btn.tag] isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = picture_Arr_goods_id[btn.tag];
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (picture_Arr_href[btn.tag] != nil && ![picture_Arr_href[btn.tag] isEqualToString:@""] && ![picture_Arr_href[btn.tag] isEqualToString:@"0"]) {
        [mess_count removeFromSuperview];
        SMessageInfor * infor = [[SMessageInfor alloc] init];
        infor.type = @"广告链接";
        infor.code_Url = picture_Arr_href[btn.tag];
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    
}
- (void)joinBtnClick {
    //    SFightGroups * join = [[SFightGroups alloc] init];
    //    join.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:join animated:YES];
}
#pragma mark 返回值决定各单元格的控件
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     if (indexPath.section == 0)
     {
         GetShengqiangouListCell * commonCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GetShengqiangouListCell" forIndexPath:indexPath];
         SIndexIndex * model = shengqian_arr[indexPath.item];
         
         
         [commonCell.picImaView sd_setImageWithURL:[NSURL URLWithString:model.pict_url]
                                  placeholderImage:[UIImage imageNamed:@"无界优品默认空视图_方形"]];
         
         NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",model.title]];
         //NSTextAttachment可以将要插入的图片作为特殊字符处理
         NSTextAttachment *attch = [[NSTextAttachment alloc] init];
         //定义图片内容及位置和大小
         if ([model.biaoshi isEqualToString:@"taobao"]) {
              attch.image = [UIImage imageNamed:@"淘宝"];
         }
         else if ([model.biaoshi isEqualToString:@"tianmao"]) {
             attch.image = [UIImage imageNamed:@"天猫"];
         }
         else
         {
             attch.image = [UIImage imageNamed:@"拼多多"];
         }
        
         attch.bounds = CGRectMake(0, 0, 13.5, 13.5);
         //创建带有图片的富文本
         NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
         //将图片放在最后一位
         //[attri appendAttributedString:string];
         //将图片放在第一位
         [attri insertAttributedString:string atIndex:0];
         //用label的attributedText属性来使用富文本
         commonCell.titleLab.attributedText = attri;
         
       //  commonCell.titleLab.text=model.title;
         
         NSString *zk_final_price=[NSString stringWithFormat:@"%.2f",[model.zk_final_price floatValue]];
         NSString *reserve_price=[NSString stringWithFormat:@"%.2f",[model.reserve_price floatValue]];
         
         NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@ ¥%@",zk_final_price,reserve_price]];
         [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(zk_final_price.length+2,reserve_price.length+1)];
         [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(zk_final_price.length+2,reserve_price.length+1)];
         commonCell.priceLab.attributedText = AttributedStr;
         
         
//        NSMutableAttributedString * AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"近30天销量  %@",model.volume]];
//         [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(7 , model.volume.length+1)];
         commonCell.xiaoliangLab.text = [NSString stringWithFormat:@"近30天销量  %@",model.volume];
         
         return commonCell;
     }
    if (indexPath.section == 1) {
        //爆款专区
        SOnlineShop_hotgoodsCell *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"SOnlineShop_hotgoodsCell" forIndexPath:indexPath];
        SIndexIndex * list = hot_goods_arr[indexPath.row];
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [mCell.googImag sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodName.text=list.goods_name;
        //    mCell.goodsPrice.text=[NSString stringWithFormat:@"市场价¥%@ 已售%@",list.market_price,list.sell_num];
        
        NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"市场价¥%@ 已售%@件",list.market_price,list.sell_num]];
        [AttributedStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3,list.market_price.length+1)];
        mCell.goodsPrice.attributedText = AttributedStr;
        
        mCell.lab_use_voucher.text=  [NSString stringWithFormat:@"爆款价¥%@",list.shop_price];
        
        
        return mCell;
    }
    if (indexPath.section == 2) {
        //拼团
        SOnlineShopCell_2 *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell_2" forIndexPath:indexPath];
        [mCell.submitBtn addTarget:self action:@selector(joinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        SIndexIndex * list = group_buy_arr[indexPath.row];
        [mCell.country_logo sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_title.backgroundColor = WordColor_sub_sub;
            mCell.top_title.text = @"不可使用代金券";
        } else {
            mCell.top_title.backgroundColor = [UIColor orangeColor];
            mCell.top_title.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goods_name.text = list.goods_name;
        mCell.group_price.text = [NSString stringWithFormat:@"￥%@",list.group_price];
        mCell.simple_num.text = [NSString stringWithFormat:@"(%@人拼单价)",list.group_num];
        /*
         *不显示单买价
         *将simple_proce的高度约束设置为0
         */
        //        mCell.simple_proce.text = [NSString stringWithFormat:@"单买价:￥%@",list.shop_price];
        mCell.simple_proceHeightCons.constant = 0;
        mCell.total.text = [NSString stringWithFormat:@"已拼:%@件",list.total];
        mCell.integral.text = list.integral;
        
        /*
         *添加体验拼单商品提示
         */
        if ([list.group_type isEqualToString:@"1"]) {
            mCell.onTrialTipImageView.hidden = NO;
        }else{
            mCell.onTrialTipImageView.hidden = YES;
        }
        
        if (list.append_person.count == 0) {
            mCell.header1.hidden = YES;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 1) {
            SIndexIndex * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = YES;
        } else if (list.append_person.count == 2) {
            SIndexIndex * list_pic = list.append_person.firstObject;
            [mCell.header1 sd_setImageWithURL:[NSURL URLWithString:list_pic.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            SIndexIndex * list_pic_sub = list.append_person[1];
            [mCell.header2 sd_setImageWithURL:[NSURL URLWithString:list_pic_sub.head_pic] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
            mCell.header1.hidden = NO;
            mCell.header2.hidden = NO;
        }
        
        
        return mCell;
    }
    
   
    
    SOnlineShopCell *mCell = [_mCollection dequeueReusableCellWithReuseIdentifier:@"SOnlineShopCell" forIndexPath:indexPath];
    
    //批量选择按钮
    mCell.choiceBtn.hidden = YES;
    mCell.top_oneImage_WWW.constant = 36;
    
    /*
    //限量购
    if (indexPath.section == 0) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.time_submit.hidden = YES;//提醒我
        
        //        mCell.blue_Num.text = @"已抢购19件";
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = NO;
        mCell.blueView_HHH.constant = 30;//30
        
        SIndexIndex * list = limit_buy_arr[indexPath.row];
        
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.limit_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
        mCell.model = limit_buy_arr[indexPath.row];
        [mCell.blue_pro setProgress:[list.sell_num floatValue]/([list.sell_num floatValue] + [list.limit_store floatValue])];
        mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/([list.sell_num floatValue] + [list.limit_store floatValue]) * 100];
        
    }
     */
    //票券区
    if (indexPath.section == 3) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = NO;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.timeView.hidden = YES;
        mCell.timeView_HHH.constant = 0;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SIndexIndex * list = ticket_buy_arr[indexPath.row];
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
        
    }
    //无界预购
    if (indexPath.section == 4) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.time_submit.hidden = YES;//提醒我
        mCell.blue_Num.text = @"已预购100件";
        
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = NO;
        mCell.blueView_HHH.constant = 30;//30
        
        SIndexIndex * list = pre_buy_arr[indexPath.row];
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.deposit];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.blue_Num.text = [NSString stringWithFormat:@"已抢购%@件",list.sell_num];
        mCell.model = pre_buy_arr[indexPath.row];
        [mCell.blue_pro setProgress:[list.sell_num floatValue]/[list.success_max_num floatValue]];
        mCell.blue_proNum.text = [NSString stringWithFormat:@"%.0f%%",[list.sell_num floatValue]/[list.success_max_num floatValue] * 100];
    }
    //进口馆
    if (indexPath.section == 5) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = NO;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.timeView.hidden = YES;
        mCell.timeView_HHH.constant = 0;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SIndexIndex * list = country_arr[indexPath.row];
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        mCell.integral_num.text = [NSString stringWithFormat:@"已售%@件",list.sell_num];
    }
    //竞拍汇
    if (indexPath.section == 6) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = NO;
        mCell.goods_priceHHH.constant = 30;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.time_submit.hidden = YES;//提醒我
        
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SIndexIndex * list = auction_arr[indexPath.row];
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        mCell.goods_priceOne.text = [NSString stringWithFormat:@"￥%@",list.start_price];
        mCell.goods_priceTwo.text = [NSString stringWithFormat:@"￥%@",list.market_price];
        mCell.integral_price.text = list.integral;
        
        mCell.model = auction_arr[indexPath.row];
        
    }
    //积分抽奖
    if (indexPath.section == 7) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.goodsImage_HHH.constant = 40;//40;
        mCell.top_twoView_HHH.constant = 40;//40;
        mCell.top_twoView.hidden = YES;
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = YES;
        mCell.goods_priceHHH.constant = 0;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.redView.hidden = NO;
        mCell.redView_HHH.constant = 30;//30
        
        mCell.timeView.hidden = NO;
        mCell.timeView_HHH.constant = 30;//30
        mCell.time_submit.hidden = YES;
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        SIndexIndex * list = one_buy_arr[indexPath.row];
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.country_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.ticket_buy_discount];
        }
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.goods_name;
        [mCell.red_pro setProgress:(1 - [list.diff_num floatValue]/[list.person_num floatValue])];
        mCell.red_num.text = [NSString stringWithFormat:@"总需%@人次",list.person_num];
        mCell.red_numSub.text = list.diff_num;
        mCell.integral_price.text = list.integral;
        mCell.model = one_buy_arr[indexPath.row];
    }
    //汽车购
    if (indexPath.section == 8) {
        mCell.top_oneView.hidden = NO;
        mCell.top_oneView_HHH.constant = ScreenW/2 - 2.5 + 40 + 70 + 30 + 20;//0
        mCell.top_twoView.hidden = NO;
        
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = YES;
        mCell.goods_priceHHH.constant = 0;//30
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.carView.hidden = NO;
        mCell.carView_HHH.constant = 70;//70
        
        mCell.houseView.hidden = YES;
        mCell.houseView_HHH.constant = 0;//90
        
        mCell.timeView.hidden = YES;
        mCell.timeView_HHH.constant = 0;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        mCell.goodsImage_HHH.constant = 30;//40;
        mCell.top_twoView_HHH.constant = 0;//40;
        
        SIndexIndex * list = car_arr[indexPath.row];
        NSMutableAttributedString * str_topTwo = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"提车地点距您%@公里",list.distance]];
        [str_topTwo addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, list.distance.length)];
        mCell.top_twoTitle.attributedText = str_topTwo;
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.car_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.car_name;
        mCell.car_price.text = [NSString stringWithFormat:@"￥%@",list.pre_money];
        mCell.car_priceContent.text = [NSString stringWithFormat:@"可   抵：￥%@车款",list.true_pre_money];
        mCell.car_priceAll.text = [NSString stringWithFormat:@"车全价：￥%@",list.all_price];
        mCell.integral_price.text = list.integral;
        [mCell.top_oneImage sd_setImageWithURL:[NSURL URLWithString:list.brand_logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.top_oneImage_WWW.constant = 22;
        if ([list.ticket_buy_discount integerValue] == 0) {
            mCell.top_oneTitle.backgroundColor = WordColor_sub_sub;
            mCell.top_oneTitle.text = @"不可使用代金券";
        } else {
            mCell.top_oneTitle.backgroundColor = [UIColor orangeColor];
            mCell.top_oneTitle.text = [NSString stringWithFormat:@"最多可用%@%%代金券",list.integral];
        }
    }
    //房产购
    if (indexPath.section == 9) {
        mCell.top_oneView.hidden = YES;
        mCell.top_oneView_HHH.constant = 0;//0
        mCell.top_twoView.hidden = NO;
        
        mCell.integral_num.hidden = YES;//已售xx件
        
        mCell.goods_PriceView.hidden = YES;
        mCell.goods_priceHHH.constant = 0;//30
        
        mCell.redView.hidden = YES;
        mCell.redView_HHH.constant = 0;//30
        
        mCell.carView.hidden = YES;
        mCell.carView_HHH.constant = 0;//70
        
        mCell.houseView.hidden = NO;
        mCell.houseView_HHH.constant = 90;//90
        
        mCell.timeView.hidden = YES;
        mCell.timeView_HHH.constant = 0;//30
        mCell.blueView.hidden = YES;
        mCell.blueView_HHH.constant = 0;//30
        
        mCell.goodsImage_HHH.constant = 30;//40;
        mCell.top_twoView_HHH.constant = 0;//40;
        
        SIndexIndex * list = house_arr[indexPath.row];
        NSMutableAttributedString * str_topTwo = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"此楼盘距您%@公里",list.distance]];
        [str_topTwo addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, list.distance.length)];
        mCell.top_twoTitle.attributedText = str_topTwo;
        [mCell.goodsImage sd_setImageWithURL:[NSURL URLWithString:list.house_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        mCell.goodsTitle.text = list.house_name;
        mCell.house_titleSub.text = list.developer;
        NSMutableAttributedString * str_around = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@-%@/平",list.min_price,list.max_price]];
        [str_around addAttribute:NSForegroundColorAttributeName value:WordColor_sub range:NSMakeRange(1 + list.min_price.length + list.max_price.length, 2)];
        mCell.house_around.attributedText = str_around;
        
        NSMutableAttributedString * str_num = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"在售房源 %@套",list.now_num]];
        [str_num addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, list.now_num.length)];
        mCell.house_num.attributedText = str_num;
        
        mCell.integral_price.text = list.integral;
    }
    
    
    return mCell;
}
#pragma mark collectionView的点击事件（代理方法）
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SIndexIndex * model =shengqian_arr[indexPath.item];
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:model.item_url];
        if (@available(iOS 10.0, *)) {
            [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                NSLog(@"Open %@",model.item_url);
            }];
        } else {
            // Fallback on earlier versions
            BOOL success = [application openURL:URL];
            NSLog(@"Open %@: %d",model.item_url,success);
        }
        return;
    }
 
    SGoodsInfor * info = [[SGoodsInfor alloc] init];
    if (indexPath.section == 1) {
//        SIndexIndex * list = limit_buy_arr[indexPath.row];
//
//        [mess_count removeFromSuperview];
//        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
//        info.goods_id = list.limit_buy_id;
//        info.overType = @"限量购";
//        info.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:info animated:YES];
//        return;
        
        [mess_count removeFromSuperview];
        SIndexIndex * list = hot_goods_arr[indexPath.row];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (indexPath.section == 2) {
        SIndexIndex * list = group_buy_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.group_buy_id;
        info.overType = @"拼单购";
        info.a_id=list.a_id;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (indexPath.section == 3) {
        SIndexIndex * list = ticket_buy_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (indexPath.section == 4) {
        SIndexIndex * list = pre_buy_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.pre_buy_id;
        info.overType = @"无界预购";
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
        
    }
    if (indexPath.section == 5) {
        SIndexIndex * list = country_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SGoodsInfor_first * info = [[SGoodsInfor_first alloc] init];
        info.goods_id = list.goods_id;
        info.overType = NULL;
        info.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:info animated:YES];
        return;
    }
    if (indexPath.section == 6) {
        SIndexIndex * list = auction_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SLotInfor * lot = [[SLotInfor alloc] init];
        lot.auction_id = list.auction_id;
        lot.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lot animated:YES];
        return;
    }
    if (indexPath.section == 7) {
        SIndexIndex * list = one_buy_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SIndianaInfor * infor = [[SIndianaInfor alloc] init];
        infor.one_buy_id = list.one_buy_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
    if (indexPath.section == 8) {
        SIndexIndex * list = car_arr[indexPath.row];
        info.goods_type = @"汽车购";
        info.goods_id = list.car_id;
    }
    if (indexPath.section == 9) {
        SIndexIndex * list = house_arr[indexPath.row];
        
        [mess_count removeFromSuperview];
        SHouseInfor * infor = [[SHouseInfor alloc] init];
        infor.house_id = list.house_id;
        infor.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infor animated:YES];
        return;
    }
 
    [mess_count removeFromSuperview];
    info.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:info animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > ScreenW) {
        _moveTopBtn.hidden = NO;
    } else {
        _moveTopBtn.hidden = YES;
    }
    UIColor * color = [UIColor redColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        top.bannerTopImage.hidden = YES;
        //        home_search.thisSearchView.backgroundColor = [UIColor whiteColor];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        top.bannerTopImage.hidden = NO;
        //        home_search.thisSearchView.backgroundColor = [UIColor colorWithRed:239/255.0 green:244/255.0 blue:244/255.0 alpha:0.5];
    }
    
    //获取tableView当前的y偏移
    CGFloat contentOffsety  = scrollView.contentOffset.y;
    //如果当前的section还没有超出navigationBar，那么就是默认的tableView的contentInset
    if (contentOffsety<=(200-64)&&contentOffsety>=0) {
        _mCollection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //当section将要就如navigationBar的后面时，改变tableView的contentInset的top，那么section的悬浮位置就会改变
    else if(contentOffsety>=200-64){
        _mCollection.contentInset  = UIEdgeInsetsMake(64, 0, 0, 0);
    }
}

#pragma mark - 判断版本号
- (BOOL)isNO:(NSString *)c1 {
    // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *localVerson = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    //将版本号按照.切割后存入数组中
    NSArray *localArray = [localVerson componentsSeparatedByString:@"."];
    NSMutableArray * localArray_sub = [[NSMutableArray alloc] init];
    [localArray_sub addObjectsFromArray:localArray];
    NSArray *appArray = [c1 componentsSeparatedByString:@"."];
    NSMutableArray * appArray_sub = [[NSMutableArray alloc] init];
    [appArray_sub addObjectsFromArray:appArray];
    
    NSInteger num = 0;//循环次数
    if (localArray_sub.count > appArray_sub.count) {
        num = localArray_sub.count;
        for (int i = 0; i < localArray_sub.count - appArray_sub.count; i++) {
            [appArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count < appArray_sub.count) {
        num = appArray_sub.count;
        for (int i = 0; i < appArray_sub.count - localArray_sub.count; i++) {
            [localArray_sub addObject:@"0"];
        }
    }
    if (localArray_sub.count == appArray_sub.count) {
        num = localArray_sub.count;
    }
    if (localArray_sub == appArray_sub) {
        return NO;
    }
    for(int i = 0; i < num; i++){//以最短的数组长度为遍历次数,防止数组越界
        //取出每个部分的字符串值,比较数值大小
        if([localArray_sub[i] integerValue] > [appArray_sub[i] integerValue]) {
            //从前往后比较数字大小,一旦分出大小,跳出循环
            return NO;
        }
    }
    return YES;
}

@end

